import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadbrochuresScreen extends StatefulWidget {
  const UploadbrochuresScreen({super.key});

  @override
  State<UploadbrochuresScreen> createState() => _UploadbrochuresScreenState();
}

class _UploadbrochuresScreenState extends State<UploadbrochuresScreen> {
  List<Map<String, String>> uploadedItems = []; // Holds uploaded files
  String searchQuery = ""; // For search functionality

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], withData: true);

    if (result != null) {
      PlatformFile file = result.files.single;

      //String? fileExtension = file.extension?.toLowerCase();
      if (file.extension == null ||
          !['pdf', 'jpg', 'jpeg', 'png']
              .contains(file.extension!.toLowerCase())) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Invalid file type. Only PDF, JPG, JPEG & PNG are allowed."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (file.size > 30 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("File size should not exceed 30MB."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

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
                Text(
                  "Wait for a while...\n\n\n\n\n\n File is getting uploaded.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      );

      try {
        if (file.bytes == null) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          // Close the loading dialog
          throw Exception("File content is empty.");
        }

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://192.168.0.110:5000/upload'),
        );
        request.fields['staff_id'] = '123';
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            file.bytes!,
            filename: file.name,
          ),
        );

        var response = await request.send().timeout(Duration(seconds: 1500),
            onTimeout: () {
          throw Exception("Request timed out");
        });

        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
// Close the loading dialog

        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var data = json.decode(responseData);

          if (mounted) {
            setState(() {
              uploadedItems.add({
                "name": data['file_name'],
                "dateTime": data['created_at'],
                "type": "pdf",
                "staffId": data['staff_id'],
              });
            });
          }
          print("File upload initiated...");
          print("Response Status Code: ${response.statusCode}");
          print("Response Body: ${await response.stream.bytesToString()}");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("File uploaded successfully!")),
          );
        } else {
          throw Exception("Upload failed: ${response.reasonPhrase}");
        }
      } catch (e) {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
        // Close the loading dialog in case of errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
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
              "Welcome\n{staff_name_here}",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 30),
            ),
          ),
          Positioned(
            top: 120,
            left: 10,
            child: Text(
              "Upload Brochures or Images to ChatPLS to do\n\n\n\n\n\n\nsearching and find exact match.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),

          //UploadBrochures|Images Button Widget
          Positioned(
            top: 150,
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
                    "UPLOAD BROCHURES|IMAGES",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 15,
                          color: const Color(0xFFF9ECC8),
                        ),
                  ),
                ),
              ),
            ),
          ),

          //SearchBrochuresWidget
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
              top: 310,
              left: 10,
              right: 0,
              child: Text(
                "Uploaded Brochures & Images",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 25,
                    ),
              )),

          //!Widget to display the List of uploaded files..
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
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(
                        item['type'] == 'pdf'
                            ? Icons.picture_as_pdf
                            : Icons.image,
                        color: Color(0xFFF9ECC8),
                        size: 30,
                      ),
                      title: Text(item['name']!.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFFF9ECC8),
                            fontFamily: 'Saira',
                            fontWeight: FontWeight.w800,
                          )),
                      subtitle: Text(
                        "\n\n\nUploaded on:\n\n\n\n\n\n${item['dateTime']}\n\n\n\n\n\nUploaded by: ${item['staffId']}\n\n",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF9ECC8),
                          fontSize: 12,
                        ),
                      ),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.delete, color: Color(0xFFF9ECC8)),
                        onPressed: () {
                          setState(() {
                            uploadedItems.removeAt(index);
                          });
                        },
                      ),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
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
