import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/auth/api/auth_api.dart';
import 'package:todo_list/auth/service/auth_service.dart';
import 'package:todo_list/common/components/buttons/primary_button.dart';
import 'package:todo_list/common/components/form/calendar_text_field.dart';
import 'package:todo_list/common/components/form/select_field.dart';
import 'package:todo_list/common/components/form/tags_controll.dart';
import 'package:todo_list/common/components/form/text_input.dart';
import 'package:todo_list/user/config/user_positions.dart';
import 'package:todo_list/validators/requre_field.dart';

import '../../service/request/request_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final UserPositionsList userPositions = UserPositionsList();
  final List<String> technology = [];

// text input controller

  final Map<String, TextEditingController> sigUpController = {
    'name': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    "birthDate": TextEditingController(),
    'cooperationStartDate': TextEditingController(),
    'positions': TextEditingController()
  };
  final AuthService authService = AuthService();

  late bool isError;
  void signUp() async {
    try {
      Map<String, dynamic> payload = {
        'technologies': technology,
        'cooperationStartDate': sigUpController['cooperationStartDate']!.text,
        'positions': [sigUpController['positions']!.text],
        'deviceName': 'm',
        'email': sigUpController['email']!.text,
        'name': sigUpController['name']!.text,
        'lastName': sigUpController['lastName']!.text,
        'password': sigUpController['password']!.text,
        'birthDate': sigUpController['birthDate']!.text
      };
      await authService.signUp(payload);
    } catch (e) {
      print('Error in sign up: ${(e as DioErrorWrapper).errorMessage}');
    }
    print(isError);
  }

  @override
  void initState() {
    sigUpController['cooperationDate']?.text =
        ""; //set the initial value of text field
    sigUpController['birthday']?.text = '';
    isError = false;

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
                        controller: sigUpController['name'],
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
                      controller: sigUpController['birthDate'],
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
                            sigUpController['birthDate']?.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                    const SizedBox(height: 10),
                    CalendarTextField(
                      validator: requreField,
                      hintText: 'Date of start cooperation',
                      controller: sigUpController['cooperationStartDate'],
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
                            sigUpController['cooperationStartDate']?.text =
                                formattedDate;
                          });
                        } else {}
                      },
                    ),
                    const SizedBox(height: 10),
                    SelectControll(
                      options: userPositions.options,
                      validator: requreField,
                      hintText: 'Select position',
                      controller: sigUpController['positions'],
                    ),
                    const SizedBox(height: 10),
                    TagsControll(
                      isError: isError,
                      tags: technology,
                      validator: requreField,
                      hintText: 'Enter your technology',
                    ),
                    const SizedBox(height: 10),
                    PrimaryButton(
                      onTap: () {
                        setState(() {
                          if (technology.isEmpty) {
                            isError = true;
                          } else {
                            isError = false;
                          }
                        });
                        if (_formKey.currentState!.validate()) {
                          signUp();
                          _formKey.currentState!.reset();
                          //  Navigator.pushNamed(context, '/home');
                        }
                      },
                      texContent: 'Register',
                    ),
                  ],
                )),
          ],
        )),
      )),
    );
  }
}
