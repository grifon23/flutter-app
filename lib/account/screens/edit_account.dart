import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/account/api/account_api.dart';
import 'package:todo_list/account/bloc/account_bloc.dart';
import 'package:todo_list/account/models/user_model.dart';
import 'package:todo_list/root/navigation/routes_names.dart';

import '../../common/components/buttons/primary_button.dart';
import '../../common/components/form/calendar_text_field.dart';
import '../../common/components/form/select_field.dart';
import '../../common/components/form/tags_controll.dart';
import '../../common/components/form/text_input.dart';
import '../../common/components/image/avatar_image.dart';
import '../../service/file_service/file_service.dart';
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
  late int userId;
  final fileService = FileService();

  final Map<String, TextEditingController> accountController = {
    'name': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    "birthDate": TextEditingController(),
    'cooperationStartDate': TextEditingController(),
    'positions': TextEditingController()
  };

  late File? _image;
  late ParamsFile params;
  final picker = ImagePicker();
  late XFile file;

  final accountApi = AccountApi();

  void uploadAvatar() async {
    try {
      await fileService.upload(
          params, file, accountApi.getAvatarLink, accountApi.finishUploadReq);
    } catch (e) {}
  }

  setForm(UserModel user) {
    Map<String, dynamic> mapUser = user.toMap(); // або будь-який інший ключ

    accountController.forEach((key, controller) {
      controller.text = mapUser[key].toString() ?? '';
    });
    userId = user.id;
    technology = List<String>.from(
        mapUser['technologies'] != null ? mapUser['technologies'] : []);
  }

  final AccountService accountService = AccountService();
  void saveAccount() async {
    try {
      Map<String, dynamic> payload = {
        'technologies': technology,
        'cooperationStartDate': accountController['cooperationStartDate']?.text,
        'positions': [accountController['positions']?.text],
        'email': accountController['email']?.text,
        'name': accountController['name']?.text,
        'lastName': accountController['lastName']?.text,
        'birthDate': accountController['birthDate']?.text
      };
      if (_image != null) {
        uploadAvatar();
        accountBloc.add(UpdateAccount(updatedUser: payload));
      }
      accountBloc.add(UpdateAccount(updatedUser: payload));
    } catch (e) {
      print('error edit ${(e as DioErrorWrapper).errorMessage}');
    }
  }

  String getMimeType(String url) {
    var splitPath = url.split('.');
    return 'image/${splitPath[splitPath.length - 1]}}';
  }

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        String mimeType = getMimeType(pickedFile.path);
        file = pickedFile;
        _image = File(pickedFile.path);
        params = ParamsFile(
            filename: pickedFile.name, mimetype: mimeType, userId: userId);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        file = pickedFile;
        String mimeType = getMimeType(pickedFile.path);
        params = ParamsFile(
            filename: pickedFile.name, mimetype: mimeType, userId: userId);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  late bool isError;
  @override
  void initState() {
    super.initState();
    isError = false;
    accountBloc.add(LoadAccount());
    _image = File('');
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
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    showOptions();
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: _image!.path.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            _image!,
                            height: 160.0,
                            width: 160.0,
                            fit: BoxFit.cover,
                          ),
                        )
                      : AvatarImage(url: user.avatarUrl),
                )),
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
                          value: state.user.positions != null
                              ? accountController['positions']?.text
                              : null,
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
                              saveAccount();
                              context.pop(UserStack.Account);

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
