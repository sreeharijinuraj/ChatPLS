import 'package:flutter/material.dart';

class UploadbrochuresScreen extends StatelessWidget {
  const UploadbrochuresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure type is fixed
        backgroundColor: Color(0xFFFF9F07), // Set background color
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload,
            ),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: "AI Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: "Account",
          ),
        ],
        unselectedItemColor: Color(0xFFF9ECC8), selectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(size: 33),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/CHATPLSLOGO2.png',
              width: 72,
              height: 72,
            ),
            const SizedBox(width: 0), // Spacing between the image and text
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Chat",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Color(0xFFFF9F07)),
                  ),
                  TextSpan(
                    text: "PLS",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Color(0xFFE6AC11)),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor:
            Colors.transparent, // Optional: Makes the AppBar transparent
        elevation: 0, // Optional: Removes shadow for a flat design
      ),
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
                      //color: Color(0xFFF9ECC8),
                      child: Text(
                        textAlign: TextAlign.center,
                        "UPLOAD BROCHURES|IMAGES",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Color(0xFFF9ECC8),
                              fontSize: 15,
                              fontFamily: 'Saira',
                              fontWeight: FontWeight.w500,
                              height: 3.47,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
