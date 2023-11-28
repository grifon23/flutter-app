import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/common/components/buttons/primary_button.dart';
import 'package:todo_list/common/components/form/calendar_text_field.dart';
import 'package:todo_list/common/components/form/text_input.dart';
import 'package:todo_list/validators/requre_field.dart';

extension Data on Map<String, TextEditingController> {
  Map<String, dynamic> data() {
    final res = <String, dynamic>{};
    for (MapEntry<String, TextEditingController> entry in entries) {
      res.putIfAbsent(entry.key, () => entry.value?.text);
    }
    return res;
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

// text input controller

  final Map<String, TextEditingController> sigUpController = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    "birthday": TextEditingController(),
    'cooperationDate': TextEditingController()
  };

  void signUp() {
    if (_formKey.currentState!.validate()) {
      final data = sigUpController.data();
      _formKey.currentState?.reset();
      print(data);
    }
  }

  @override
  void initState() {
    sigUpController['cooperationDate']?.text =
        ""; //set the initial value of text field
    sigUpController['birthday']?.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.grey[300],
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 35),
            Image.asset(
              'lib/images/logo.png',
              height: 100,
            ),
            const SizedBox(height: 35),
            Text(
              'Register',
              style: TextStyle(color: Colors.grey[700], fontSize: 18),
            ),
            const SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    BaseTextField(
                        validator: requreField,
                        controller: sigUpController['firstName'],
                        hintText: 'First name',
                        obscureText: false),
                    const SizedBox(height: 10),
                    BaseTextField(
                        validator: requreField,
                        controller: sigUpController['lastName'],
                        hintText: 'Last name',
                        obscureText: false),
                    const SizedBox(height: 10),
                    BaseTextField(
                        validator: requreField,
                        controller: sigUpController['email'],
                        hintText: 'Email',
                        obscureText: false),
                    const SizedBox(height: 10),
                    BaseTextField(
                        validator: requreField,
                        controller: sigUpController['password'],
                        hintText: 'Pasword',
                        obscureText: true),
                    const SizedBox(height: 10),
                    CalendarTextField(
                      validator: requreField,
                      hintText: 'Birthday',
                      controller: sigUpController['birthday'],
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          context: context,
                          initialDate: null,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          setState(() {
                            sigUpController['birthday']?.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                    const SizedBox(height: 10),
                    CalendarTextField(
                      validator: requreField,
                      hintText: 'Date of start cooperation',
                      controller: sigUpController['cooperationDate'],
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          context: context,
                          initialDate: null,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          setState(() {
                            sigUpController['cooperationDate']?.text =
                                formattedDate;
                          });
                        } else {}
                      },
                    ),
                    const SizedBox(height: 35),
                    PrimaryButton(
                      onTap: signUp,
                      texContent: 'Register',
                    )
                  ],
                )),
          ],
        )),
      )),
    );
  }
}
