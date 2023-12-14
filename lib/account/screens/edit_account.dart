import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/account/bloc/account_bloc.dart';
import 'package:todo_list/account/models/user_model.dart';

import '../../common/components/buttons/primary_button.dart';
import '../../common/components/form/calendar_text_field.dart';
import '../../common/components/form/select_field.dart';
import '../../common/components/form/tags_controll.dart';
import '../../common/components/form/text_input.dart';
import '../../service/request/request_service.dart';
import '../../user/config/user_positions.dart';
import '../../validators/requre_field.dart';
import '../services/account_service.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final accountBloc = AccountBloc(accountService: AccountService());
  final _formKey = GlobalKey<FormState>();
  final UserPositionsList userPositions = UserPositionsList();
  late List<String> technology = [];

  final Map<String, TextEditingController> accountController = {
    'name': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    "birthDate": TextEditingController(),
    'cooperationStartDate': TextEditingController(),
    'positions': TextEditingController()
  };

  setForm(UserModel user) {
    Map<String, dynamic> mapUser = user.toMap(); // або будь-який інший ключ

    accountController.forEach((key, controller) {
      controller.text = mapUser[key]?.toString() ?? '';
    });

    technology = List<String>.from(mapUser['technologies'] ?? []);
  }

  late bool isError;
  @override
  void initState() {
    super.initState();
    isError = false;

    accountBloc.add(LoadAccount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<AccountBloc, AccountState>(
        bloc: accountBloc,
        builder: (context, state) {
          if (state is AccountLoaded) {
            final user = state.user;
            setForm(user);
            return SingleChildScrollView(
              child: Column(children: [
                Center(
                  child: InkWell(
                      onTap: () {
                        print('press image');
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade200)),
                          child: user.avatarUrl != null
                              ? Image.network(
                                  user.avatarUrl!,
                                  height: 160.0,
                                  width: 160.0,
                                )
                              : const Icon(
                                  Icons.account_circle,
                                  size: 160.0,
                                ))),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BaseTextField(
                            validator: requreField,
                            controller: accountController['name'],
                            hintText: 'First name',
                            obscureText: false),
                        const SizedBox(height: 10),
                        BaseTextField(
                            validator: requreField,
                            controller: accountController['lastName'],
                            hintText: 'Last name',
                            obscureText: false),
                        const SizedBox(height: 10),
                        BaseTextField(
                            validator: requreField,
                            controller: accountController['email'],
                            hintText: 'Email',
                            obscureText: false),
                        const SizedBox(height: 10),
                        CalendarTextField(
                          validator: requreField,
                          hintText: 'Birthday',
                          controller: accountController['birthDate'],
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              context: context,
                              initialDate: null,
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              setState(() {
                                accountController['birthDate']?.text =
                                    formattedDate;
                              });
                            } else {}
                          },
                        ),
                        const SizedBox(height: 10),
                        CalendarTextField(
                          validator: requreField,
                          hintText: 'Date of start cooperation',
                          controller: accountController['cooperationStartDate'],
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              context: context,
                              initialDate: null,
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              setState(() {
                                accountController['cooperationStartDate']
                                    ?.text = formattedDate;
                              });
                            } else {}
                          },
                        ),
                        const SizedBox(height: 10),
                        SelectControll(
                          options: userPositions.options,
                          validator: requreField,
                          hintText: 'Select position',
                          controller: accountController['positions'],
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
                              _formKey.currentState!.reset();
                              //  Navigator.pushNamed(context, '/home');
                            }
                          },
                          texContent: 'Save',
                        ),
                      ],
                    )),
              ]),
            );
          }
          if (state is AccountLoadingFailure) {
            final error = (state.exeption as DioErrorWrapper).errorMessage;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$error'),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          accountBloc.add(LoadAccount());
                        },
                        child: const Text('Try again'),
                      )
                    ]),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}