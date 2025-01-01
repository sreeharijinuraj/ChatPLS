import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';

class StaffProfileDashboardScreen extends StatelessWidget {
  const StaffProfileDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAfterLogin(title: "Staff DashBoard"),
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
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Positioned(
                    top: 30,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 100,
                    )),
                TextButton(
                    onPressed: () {},
                    child: Container(
                        color: Color(0xFFFF9F07),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        child: Text(
                          "UPLOAD PROFILE PHOTO",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Color(0xFFF9ECC8),
                                    fontSize: 15,
                                    fontFamily: 'Saira',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                        ))),
                Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Color(0xFFFF9F07), width: 2)),
                                hintText: "Staff ID"),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(height: 50,width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Color(0xFFFF9F07), width: 2)),
                                hintText: "Staff Name"),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(height: 50,width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Color(0xFFFF9F07), width: 2)),
                                hintText: "Password"),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
