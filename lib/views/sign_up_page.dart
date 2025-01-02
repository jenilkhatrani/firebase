import 'package:firebase/utils/helpers/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Events",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.mail_outline_rounded),
                        labelText: 'Enter Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.password),
                        labelText: 'Enter Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          Map<String, dynamic> res = await AuthHelper.authHelper
                              .SignUpuser(
                                  email: emailController.text,
                                  password: passwordController.text);

                          if (res['user'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sign up successful'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Get.offAllNamed('/home_page',
                                arguments: res['user']);
                          } else if (res['error'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${res['error']}'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sign up failed'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } else {
                          print("Form validation failed");
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed("/sign_in_page");
                          },
                          child: Text("Sign In"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
