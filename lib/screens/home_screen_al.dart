import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenAl extends StatelessWidget {
  final String staffName; // Receive staff name as a parameter
  const HomeScreenAl({super.key, required this.staffName});

  Future<String> _getStaffName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('staffName') ??
        'Guest'; // Default to 'Guest' if no name is found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF9ECC8),
      appBar: const AppBarAfterLogin(title: "Home-AI"),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 15,
            child: FutureBuilder<String>(
              future: _getStaffName(), // Fetch staff name asynchronously
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator while fetching
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Welcome",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color: const Color(0xFFFF9F07),
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                    fontSize: 26)),
                        TextSpan(
                            text: ", ${staffName}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: const Color(0xFFE6AC11),
                                    fontWeight: FontWeight.w300,
                                    height: 1.5,
                                    fontSize: 26))
                      ])),
                    ],
                  );
                } else {
                  return Text(
                      "Welcome, Guest"); // Default text if no data is available
                }
              },
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            child: Text(
              "How Can I Help You Right Now ?..",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFFF9F07),
                  fontWeight: FontWeight.w100,
                  height: 1.5,
                  fontSize: 17),
            ),
          ),
          // The 3 Grids start from here
          Positioned(
            top: 90,
            left: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 360,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFF9F07),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(55),
                          bottomRight: Radius.circular(15))),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: const Icon(
                          color: Color(0xFFF9ECC8),
                          Icons.text_fields,
                          size: 50,
                        ),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Chat With",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: const Color(0xFFF9ECC8),
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                    fontSize: 26)),
                        TextSpan(
                            text: "\nChatPLS",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color: const Color(0xFFF9ECC8),
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                    fontSize: 22))
                      ]))
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      width: 200,
                      height: 180,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFF9F07),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(55))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 30),
                      child: Column(
                        children: [
                          const Icon(
                            color: Colors.deepPurple,
                            Icons.image,
                            size: 40,
                          ),
                          Text(
                            "Search With Images",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2,
                                    fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 200,
                      height: 180,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFF9F07),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(55))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 30),
                      child: Column(
                        children: [
                          const Icon(
                            color: Colors.green,
                            Icons.camera,
                            size: 40,
                          ),
                          Text(
                            "Search Using Camera",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2,
                                    fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Recent Searches Section
          Positioned(
            top: 470,
            left: 15,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Why ChatPLS ?",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFFFF9F07),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 18),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.schedule_outlined,
                        color: Color(0xFFFF9F07), size: 45),
                    Icon(Icons.image_search_outlined,
                        color: Color(0xFFE6AC11), size: 45),
                    Icon(Icons.diversity_1_outlined,
                        color: Color(0xFFFF9F07), size: 45),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Saves Your \nTime",
                      textAlign: TextAlign.center,
                    ),
                    Text("Accurate Product \nSearch",
                        textAlign: TextAlign.center),
                    Text("Good Customer \nInteraction",
                        textAlign: TextAlign.center),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
