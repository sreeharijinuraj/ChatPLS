import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';

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
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'], // Restrict extensions
    );

    if (result != null) {
      PlatformFile file = result.files.single;

      // Manually validate the file extension
      String? fileExtension = file.extension?.toLowerCase();
      if (fileExtension == null ||
          !['pdf', 'jpg', 'jpeg', 'png'].contains(fileExtension)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Invalid file type. Only PDF, JPG, JPEG & PNG are allowed."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Check file size (in bytes; 30MB = 30 * 1024 * 1024)
      if (file.size > 30 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("File size should not exceed 30MB."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Assuming staff ID and timestamp are predefined for now
      String staffId = "STAFF123";
      String timestamp = DateTime.now().toString();

      setState(() {
        uploadedItems.add({
          "name": file.name,
          "dateTime": timestamp,
          "type": file.extension ?? "unknown",
          "staffId": staffId,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedItems = uploadedItems.where((item) {
      return item['name']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const AppBarAfterLogin(title: "Upload Brochures"),
      body: Stack(
        children: [
          Positioned(
            top: 15,
            left: 10,
            child: Text(
              "Welcome\n{staff_name_here}",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 25,
                    ),
              )),

          //Widget to display the List of uploaded files..
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
