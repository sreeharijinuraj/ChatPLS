import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StaffProfileDashboardForstaffonly extends StatefulWidget {
  final String staffName;

  const StaffProfileDashboardForstaffonly({super.key, required this.staffName});

  @override
  _StaffProfileDashboardForstaffonlyState createState() =>
      _StaffProfileDashboardForstaffonlyState();
}

class _StaffProfileDashboardForstaffonlyState
    extends State<StaffProfileDashboardForstaffonly> {
  late Future<String?> _staffIdFuture;

  @override
  void initState() {
    super.initState();
    _staffIdFuture = fetchStaffId(widget.staffName);
  }

  Future<String?> fetchStaffId(String staffName) async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('staffs')
        .select('staff_id')
        .ilike('name', staffName) // Case-insensitive search
        .maybeSingle(); // Prevents errors if not found

    if (response == null) {
      return null; // Staff ID not found
    }
    return response['staff_id'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9ECC8),
      appBar: const AppBarAfterLogin(title: "Staff Dashboard Only For Staffs"),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            right: 0,
            child: Text(
              "Profile Dashboard Of Staffs",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 22, color: const Color(0xFFFF9F07)),
            ),
          ),
          Positioned(
            top: 45,
            height: 250,
            left: 0,
            right: 0,
            child: Container(
              color: const Color(0xFFFF9F07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 90,
                        color: Color(0xFFF9ECC8),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF9ECC8),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "UPLOAD",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: const Color(0xFFFF9F07),
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Name : ${widget.staffName}",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder<String?>(
                          future: _staffIdFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Fetching Staff ID...");
                            } else if (snapshot.hasError ||
                                snapshot.data == null) {
                              return const Text("STAFF ID: Not Found");
                            }
                            return Text("STAFF ID : ${snapshot.data}");
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text("Password : xxxxxxxx"),
                        const SizedBox(height: 10),
                        Text(
                          "Reset Password?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: const Color(0xFFF9ECC8)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
