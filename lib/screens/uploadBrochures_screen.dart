import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';

class UploadbrochuresScreen extends StatelessWidget {
  const UploadbrochuresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for ListView
    final uploadedItems = [
      {
        "name": "Sample PDF 1",
        "dateTime": "2024-12-30 10:00 AM",
        "type": "pdf",
        "staffId": "STAFFPLS001"
      },
      {
        "name": "Sample Image 1",
        "dateTime": "2024-12-30 11:15 AM",
        "type": "image",
        "staffId": "STAFFPLS002"
      },
      {
        "name": "Sample PDF 2",
        "dateTime": "2024-12-30 12:45 PM",
        "type": "pdf",
        "staffId": "STAFFPLS003"
      },
      {
        "name": "Sample PDF 3",
        "dateTime": "2024-12-30 4:45 PM",
        "type": "pdf",
        "staffId": "STAFFPLS003"
      },
    ];

    return Scaffold(
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //       border: Border(top: BorderSide(color: Color(0xFFF9ECC8)))),
      //   child: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     backgroundColor: Color(0xFFFF9F07),
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "Home",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.upload),
      //         label: "Upload",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.add),
      //         label: "AI Chat",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle),
      //         label: "Account",
      //       ),
      //     ],
      //     unselectedItemColor: Color(0xFFF9ECC8),
      //     selectedItemColor: Colors.black,
      //     unselectedIconTheme: IconThemeData(size: 33),
      //   ),
      // ),
     appBar: const AppBarAfterLogin(title: "Upload Brochures"),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: 10,
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Welcome\n{staff_name_here}",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      fontSize: 30),
                ),
              ])),
            ),
            Positioned(
              top: 120,
              left: 10,
              child: Text(
                "Upload Brochures or Images to ChatPLS to do\n\n\n\n\n\n\nsearching and find exact match.",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
            ),
            Positioned(
              top: 150,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      print("UPLOAD BROCHURES button clicked");
                    },
                    child: Container(
                      width: 300,
                      height: 28,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color(0xFFFF9F07)),
                      child: Text(
                        textAlign: TextAlign.center,
                        "UPLOAD BROCHURES|IMAGES",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Color(0xFFF9ECC8),
                              fontSize: 15,
                              fontFamily: 'Saira',
                              fontWeight: FontWeight.w500,
                              height: 2,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 210,
              left: 10,
              child: Text(
                "Upload Brochures & Images",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    fontSize: 25),
              ),
            ),



            //search bar positioned 
            Positioned(
              top: 250, // Adjust the top value to place it correctly
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF9ECC8),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: Color(0xFFFF9F07), width: 2), // Orange border
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search brochures or images...",
                    hintStyle: TextStyle(color: Colors.black,fontFamily: 'Saira',fontWeight: FontWeight.w200),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search,
                        color: Color(0xFFFF9F07)), // Orange icon
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  ),
                  onChanged: (value) {
                    // Logic for searching can be added here
                    print("Search query: $value");
                  },
                ),
              ),
            ),

            //list of brochures
            Positioned(
              top: 310,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(color: Color(0xFFFF9F07),width: 1),
                //   borderRadius: BorderRadius.circular(10)),
                color: Color(0xFFFF9F07),
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: uploadedItems.length,
                  itemBuilder: (context, index) {
                    final item = uploadedItems[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Icon(
                          item['type'] == 'pdf'
                              ? Icons.picture_as_pdf
                              : Icons.image,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          item['name']!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Saira',),
                        ),
                        subtitle: Text(
                          "Uploaded on: ${item['dateTime']}\n\n\n\n\n\n"
                          "Uploaded by : ${item['staffId']}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Saira'),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon:
                                  Icon(Icons.delete, color: Color(0xFFF9ECC8)),
                              onPressed: () {
                                print("Delete clicked for ${item['name']}");
                              },
                            ),
                          ],
                        ),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
