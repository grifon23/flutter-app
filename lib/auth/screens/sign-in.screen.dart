import 'package:flutter/material.dart';
import 'package:todo_list/validators/requre_field.dart';

import '../../common/components/buttons/image_button.dart';
import '../../common/components/buttons/primary_button.dart';
import '../../common/components/form/text_input.dart';
import '../api/auth_api.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

// text input controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final authService = AuthApiService();
  // signin method
  void signIn(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        await authService.loginReq(
            emailController.text, passwordController.text);
        _formKey.currentState!.reset();
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {}
  }

  //sign google
  void signInGoogle() {
    print('signInGoogle');
  }

  //signInApple
  void signInApple() {
    print('signInApple');
  }

//register void
  void signUp(BuildContext context) {
    Navigator.pushNamed(context, '/signUp');
    print('signUp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 50),
              Image.asset(
                'lib/images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 50),
              Text(
                'Welcome back!',
                style: TextStyle(color: Colors.grey[700], fontSize: 18),
              ),
              const SizedBox(height: 25),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BaseTextField(
                        validator: requreField,
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      BaseTextField(
                        validator: requreField,
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              PrimaryButton(
                onTap: () {
                  signIn(context);
                },
                texContent: 'Sign In',
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[500],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageButton(
                    onTap: signInApple,
                    imagePath: 'lib/images/apple.png',
                    height: 40,
                  ),
                  const SizedBox(width: 15),
                  ImageButton(
                    onTap: signInGoogle,
                    imagePath: 'lib/images/google.png',
                    height: 40,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => signUp(context),
                    child: Text(
                      'Register now',
                      style: TextStyle(
                          color: Colors.blue[600], fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
