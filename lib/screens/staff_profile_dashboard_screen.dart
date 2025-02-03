import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StaffProfileDashboardScreen extends StatefulWidget {
  const StaffProfileDashboardScreen({super.key});

  @override
  _StaffProfileDashboardScreenState createState() =>
      _StaffProfileDashboardScreenState();
}

class _StaffProfileDashboardScreenState
    extends State<StaffProfileDashboardScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> staffList = [];

  @override
  void initState() {
    super.initState();
    _fetchStaffs();
  }

  Future<void> _fetchStaffs() async {
    final response = await supabase.from('staffs').select();
    setState(() {
      staffList = response;
    });
  }

  Future<String> _generateStaffId() async {
    // Fetch the last staff_id from the staffs table
    final response = await supabase
        .from('staffs')
        .select('staff_id')
        .order('staff_id', ascending: false)
        .limit(1);

    String lastStaffId = "STAFFPLS000"; // Default starting ID

    if (response.isNotEmpty && response[0]["staff_id"] != null) {
      lastStaffId = response[0]["staff_id"];
    }

    // Extract the numeric part of the last staff_id
    final numericPart =
        int.tryParse(lastStaffId.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    // Increment the numeric part and format it back
    final nextNumericPart = numericPart + 1;
    final nextStaffId = "STAFFPLS${nextNumericPart.toString().padLeft(3, '0')}";

    return nextStaffId;
  }

  Future<void> _addOrUpdateStaff({int? editIndex}) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController dobController = TextEditingController();
    String? selectedGender;

    if (editIndex != null) {
      final staff = staffList[editIndex];
      nameController.text = staff["name"];
      selectedGender = staff["gender"];
      dobController.text = staff["dob"];
      emailController.text = staff["email"];
    }

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      if (value.length > 30) {
                        return 'Name should not exceed 30 characters';
                      }
                      if (!RegExp(r'^[A-Z][a-zA-Z ]*$').hasMatch(value)) {
                        return 'Name should start with a capital letter and contain no special symbols or numbers';
                      }
                      return null;
                    },
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
                      selectedGender = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gender is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dobController,
                    readOnly: true,
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
                        // Change format to yyyy-mm-dd
                        dobController.text =
                            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date of Birth is required';
                      }
                      DateTime dob = DateTime.parse(value);
                      DateTime now = DateTime.now();
                      int age = now.year - dob.year;
                      if (now.month < dob.month ||
                          (now.month == dob.month && now.day < dob.day)) {
                        age--;
                      }
                      if (age < 18) {
                        return 'You must be at least 18 years old';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (nameController.text.isNotEmpty &&
                                selectedGender != null &&
                                dobController.text.isNotEmpty &&
                                emailController.text.isNotEmpty) {
                              if (editIndex == null) {
                                // Generate a new staff_id
                                final staffId = await _generateStaffId();

                                // Insert the new staff record
                                await supabase.from('staffs').insert({
                                  "staff_id": staffId,
                                  "name": nameController.text,
                                  "gender": selectedGender,
                                  "dob": dobController.text,
                                  "email": emailController.text,
                                });
                              } else {
                                // Update the existing staff record
                                await supabase.from('staffs').update({
                                  "name": nameController.text,
                                  "gender": selectedGender,
                                  "dob": dobController.text,
                                  "email": emailController.text,
                                }).eq("staff_id",
                                    staffList[editIndex]["staff_id"]);
                              }
                              _fetchStaffs();
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Text(editIndex == null ? "Create" : "Update"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteStaff(int index) async {
    await supabase
        .from('staffs')
        .delete()
        .eq("Staff ID", staffList[index]["Staff ID"]);
    _fetchStaffs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9ECC8),
      appBar: const AppBarAfterLogin(title: "Staff DashBoard"),
      body: Stack(
        children: [
          Positioned(
            top: 10,
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
            top: 45,
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
                  const SizedBox(width: 40),
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
                        const SizedBox(height: 10),
                        Text("STAFF ID : {staffid_here}"),
                        const SizedBox(height: 10),
                        Text("Password : xxxxxxxx"),
                        const SizedBox(height: 10),
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
                  onPressed: () => _addOrUpdateStaff(),
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
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(staff["name"] ?? "Unknown",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      fontSize: 18, color: Color(0xFFF9ECC8))),
                          subtitle: Text(
                            "Staff ID: ${staff["staff_id"]}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Color(0xFFF9ECC8)),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    Icon(Icons.edit, color: Color(0xFFF9ECC8)),
                                onPressed: () =>
                                    _addOrUpdateStaff(editIndex: index),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: staffList[index]["staff_id"] ==
                                          "ADMINPLS"
                                      ? Color.fromRGBO(36, 35, 35,
                                          0.298) // Faded color for disabled state
                                      : Colors
                                          .red, // Normal red color for enabled state
                                ),
                                onPressed:
                                    staffList[index]["staff_id"] == "ADMINPLS"
                                        ? null
                                        : () => _deleteStaff(index),
                              ),
                            ],
                          ),
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
