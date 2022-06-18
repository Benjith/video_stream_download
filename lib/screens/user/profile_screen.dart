import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_video_stream/core/app_constants.dart';
import 'package:flutter_video_stream/screens/widgets/custom_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Profile",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.yellow[600],
                  radius: 102 / 2,
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.camera_alt,
                        color: AppConstants.isDarkMode
                            ? Colors.white54
                            : Colors.black54,
                      )),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 46,
                      child: Theme(
                        data: ThemeData.light(),
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 14),
                              filled: true,
                              fillColor: const Color(0xffeff1f6),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              hintStyle:
                                  const TextStyle(color: Color(0xff313056)),
                              hintText: "Enter full name",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: Theme(
                        data: ThemeData.light(),
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 14),
                            filled: true,
                            fillColor: const Color(0xffeff1f6),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            hintStyle:
                                const TextStyle(color: Color(0xff313056)),
                            hintText: "Enter email address",
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: Theme(
                data: ThemeData.light(),
                child: TextField(
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                    filled: true,
                    fillColor: const Color(0xffeff1f6),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    hintStyle: const TextStyle(color: Color(0xff313056)),
                    prefixIcon: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text(
                          "+91",
                          style: TextStyle(color: Colors.black),
                        )),
                    hintText: "Enter phone number",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: Theme(
                data: ThemeData.light(),
                child: TextField(
                  onTap: () => _selectDate(context),
                  readOnly: true,
                  controller: TextEditingController(
                      text: selectedDate.toLocal().toString().split(' ')[0]),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                    filled: true,
                    fillColor: const Color(0xffeff1f6),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    hintStyle: const TextStyle(color: Color(0xff313056)),
                    hintText: "Enter DOB",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: Theme(
                data: ThemeData.light(),
                child: TextField(
                  obscureText: true,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                    filled: true,
                    fillColor: const Color(0xffeff1f6),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    hintStyle: const TextStyle(color: Color(0xff313056)),
                    hintText: "Enter password ",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: Theme(
                data: ThemeData.light(),
                child: TextField(
                  obscureText: true,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                    filled: true,
                    fillColor: const Color(0xffeff1f6),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    hintStyle: const TextStyle(color: Color(0xff313056)),
                    hintText: "Confirm password ",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomWidgets.submitButton("Save")
          ],
        ),
      ),
    );
  }
}
