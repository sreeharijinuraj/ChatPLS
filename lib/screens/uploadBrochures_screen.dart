import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';

class UploadbrochuresScreen extends StatefulWidget {
  final String staffName;
  const UploadbrochuresScreen({super.key, required this.staffName});

  @override
  State<UploadbrochuresScreen> createState() => _UploadbrochuresScreenState();
}

class _UploadbrochuresScreenState extends State<UploadbrochuresScreen> {
  List<Map<String, String>> uploadedItems = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadUploadedFiles();
  }

  Future<bool> checkFileExists(String fileName) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.112:5000/check_file?file_name=$fileName'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['exists'];
      } else {
        throw Exception("Failed to check file existence");
      }
    } catch (e) {
      print("Error checking file existence: $e");
      return false;
    }
  }

  Future<void> loadUploadedFiles() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.112:5000/get_uploaded_files'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("API Response from Server: $data");

        List<Map<String, String>> formattedData = (data as List).map((item) {
          return {
            "name": item["name"] != null && item["name"] != ""
                ? item["name"].toString()
                : "No Name",
            "dateTime": item["dateTime"] != null && item["dateTime"] != ""
                ? item["dateTime"].toString()
                : "No Date",
            "type": item["type"] != null && item["type"] != ""
                ? item["type"].toString()
                : "Unknown",
            "staffId": item["staffId"] != null && item["staffId"] != ""
                ? item["staffId"].toString()
                : "No ID",
          };
        }).toList();

        setState(() {
          uploadedItems = formattedData;
        });

        print("Formatted Uploaded Items: $uploadedItems");
      } else {
        throw Exception("Failed to load uploaded files");
      }
    } catch (e) {
      print("Error fetching uploaded files: $e");
    }
  }

  Future<void> saveUploadedFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uploadedFiles', json.encode(uploadedItems));
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'csv'],
        withData: true);

    if (result != null) {
      PlatformFile file = result.files.single;
      if (file.bytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Error: File bytes are null."),
              backgroundColor: Colors.red),
        );
        return;
      }

      // Check if file exists in ChromaDB
      bool fileExists = await checkFileExists(file.name);
      if (fileExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File already exists in database!")),
        );
        return;
      }

      // Show Uploading Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Uploading file... Please wait."),
              ],
            ),
          );
        },
      );

      try {
        String endpoint = file.extension!.toLowerCase() == 'csv'
            ? 'http://192.168.0.112:5000/upload_csv'
            : 'http://127.0.0.112:5000/upload';

        var request = http.MultipartRequest('POST', Uri.parse(endpoint));
        request.fields['staff_id'] = '123';
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            file.bytes!,
            filename: file.name,
            contentType: MediaType(
              file.extension!.toLowerCase() == 'csv' ? 'text' : 'application',
              file.extension!,
            ),
          ),
        );

        var response = await request.send();
        if (Navigator.canPop(context)) Navigator.of(context).pop();

        var responseData = await response.stream.bytesToString();
        print("Response from server: $responseData");

        if (response.statusCode == 200) {
          var data = json.decode(responseData);
          if (data['file_name'] == null || data['created_at'] == null) {
            throw Exception(
                "Unexpected response format: Missing required fields");
          }

          setState(() {
            uploadedItems.add({
              "name": data['file_name'],
              "dateTime": data['created_at'],
              "type": file.extension!.toLowerCase(),
              "staffId": data['staff_id'] ?? 'Unknown',
            });
          });
          await saveUploadedFiles();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("File uploaded successfully!")),
          );
        } else {
          throw Exception("Upload failed: ${response.reasonPhrase}");
        }
      } catch (e) {
        if (Navigator.canPop(context)) Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  void deleteFile(String fileName, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm Deletion",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          content: Text(
            "Are you sure you want to delete \"$fileName\"?",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog before deletion

                try {
                  final response = await http.delete(
                    Uri.parse('http://192.168.0.112:5000/delete_file'),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({"file_name": fileName}),
                  );

                  if (response.statusCode == 200) {
                    setState(() {
                      uploadedItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("File deleted successfully!")),
                    );
                  } else {
                    var error = json.decode(response.body)['error'];
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $error")),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error deleting file: $e")),
                  );
                }
              },
              child: Text(
                "Yes, Delete",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedItems = uploadedItems.where((item) {
      return item['name']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Color(0xFFF9ECC8),
      appBar: const AppBarAfterLogin(title: "Upload Brochures"),
      body: Stack(
        children: [
          Positioned(
            top: 15,
            left: 10,
            child: Text(
              "Welcome \n${widget.staffName}",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 30),
            ),
          ),
          Positioned(
            top: 110,
            left: 10,
            child: Text(
              "Upload Files to Train the ChatPLS Model & \nFind Products Easily",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
            top: 160,
            child: TextButton(
              onPressed: pickFile,
              child: Container(
                width: 300,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9F07),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "UPLOAD FILES",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 15,
                          color: const Color(0xFFF9ECC8),
                        ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF9ECC8),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFFF9F07), width: 2),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Saira',
                      fontWeight: FontWeight.w100,
                      height: 4.10),
                  hintText: "Search brochures or images...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0xFFFF9F07)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 10,
            child: Text(
              "Uploaded Brochures & Images",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 25,
                  ),
            ),
          ),
          Positioned(
            top: 340,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Color(0xFFFF9F07),
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  final item = displayedItems[index];
                  return ListTile(
                    leading: Icon(
                      item['type'] == 'pdf'
                          ? Icons.picture_as_pdf
                          : item['type'] == 'csv'
                              ? Icons.insert_drive_file // Icon for CSV files
                              : Icons.image,
                      color: Color(0xFFF9ECC8),
                      size: 30,
                    ),
                    title: Text(item['name']!.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFF9ECC8),
                          fontWeight: FontWeight.w800,
                        )),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Color(0xFFF9ECC8)),
                      onPressed: () => deleteFile(item['name']!, index),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
