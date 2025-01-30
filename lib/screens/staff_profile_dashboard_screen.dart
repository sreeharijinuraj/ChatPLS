import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';

class StaffProfileDashboardScreen extends StatefulWidget {
  const StaffProfileDashboardScreen({super.key});

  @override
  _StaffProfileDashboardScreenState createState() =>
      _StaffProfileDashboardScreenState();
}

class _StaffProfileDashboardScreenState
    extends State<StaffProfileDashboardScreen> {
  List<Map<String, String>> staffList = [];
  int? editIndex; // Class-level variable to track editing index

  void _showAddStaffDialog({int? editIndex}) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController dobController = TextEditingController();
    String? selectedGender;

    if (editIndex != null) {
      final staff = staffList[editIndex];
      nameController.text = staff["name"]!;
      selectedGender = staff["gender"]!;
      dobController.text = staff["dob"]!;
      emailController.text = staff["email"]!;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF9ECC8),
          title: Text(
            editIndex == null ? "Add Staff" : "Edit Staff",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 22, color: Color(0xFFFF9F07)),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Gender"),
                  value: selectedGender,
                  items: ["Male", "Female"].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                TextField(
                  controller: dobController,
                  readOnly: true, // Prevent manual input
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      dobController.text =
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                    }
                  },
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            selectedGender != null &&
                            dobController.text.isNotEmpty &&
                            emailController.text.isNotEmpty) {
                          setState(() {
                            if (editIndex == null) {
                              staffList.add({
                                "name": nameController.text,
                                "gender": selectedGender!,
                                "dob": dobController.text,
                                "email": emailController.text,
                                "staff_id":
                                    "staff${staffList.length + 1}", // Unique ID
                              });
                            } else {
                              staffList[editIndex] = {
                                "name": nameController.text,
                                "gender": selectedGender!,
                                "dob": dobController.text,
                                "email": emailController.text,
                                "staff_id": staffList[editIndex]
                                    ["staff_id"]!, // Keep same ID
                              };
                            }
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(editIndex == null ? "Create" : "Update"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteStaff(int index) {
    setState(() {
      staffList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9ECC8),
      appBar: const AppBarAfterLogin(title: "Staff DashBoard"),
      body: Stack(
        children: [
          Positioned(
            top: 15,
            left: 10,
            right: 0,
            child: Text(
              "Profile Dashboard",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 22, color: Color(0xFFFF9F07)),
            ),
          ),
          Positioned(
            top: 40,
            height: 250,
            left: 0,
            right: 0,
            child: Container(
              color: Color(0xFFFF9F07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 90,
                        color: Color(0xFFF9ECC8),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFF9ECC8),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "UPLOAD",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Color(0xFFFF9F07),
                                      fontWeight: FontWeight.w700),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(width: 35),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Name : {name_here}",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 25),
                        Text("STAFF ID : {staffid_here}"),
                        const SizedBox(height: 25),
                        Text("Password : xxxxxxxx"),
                        const SizedBox(height: 25),
                        Text(
                          "Reset Password?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Color(0xFFF9ECC8)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 315,
            left: 10,
            right: 0,
            child: Text(
              "Staff Management",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 22, color: Color(0xFFFF9F07)),
            ),
          ),
          Positioned(
            top: 340,
            left: 0,
            right: 0,
            child: Column(
              children: [
                TextButton(
                  onPressed: () => _showAddStaffDialog(),
                  child: Container(
                    width: 150,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9F07),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "ADD STAFFS",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 15,
                              color: const Color(0xFFF9ECC8),
                            ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 380,
                  color: Color(0xFFFF9F07),
                  child: ListView.builder(
                    itemCount: staffList.length,
                    itemBuilder: (context, index) {
                      final staff = staffList[index];
                      return ListTile(
                        leading: Icon(Icons.person, color: Color(0xFFF9ECC8)),
                        title: Text(staff["name"]!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\n\nStaff ID: ${staff["staff_id"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFF9ECC8),
                                  fontSize: 12),
                            ),
                            Text("\n\n\n\nGender: ${staff["gender"]}\n\n\n"),
                            Text("\n\n\nDOB: ${staff["dob"]}\n"),
                            Text("\n\n\n\nEmail: ${staff["email"]}\n\n\n"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () =>
                                  _showAddStaffDialog(editIndex: index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteStaff(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
