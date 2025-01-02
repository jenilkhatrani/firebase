import 'package:firebase/utils/helpers/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                "Welcome Back to Events",
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
                    // Email Field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.mail_outline_rounded),
                        focusColor: Colors.grey,
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
                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.lock),
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
                              .SignInuser(
                                  email: emailController.text,
                                  password: passwordController.text);

                          if (res['user'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sign in successfully'),
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
                                content: Text('Sign in failed'),
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
                        "Sign In",
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
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed("/sign_up_page");
                          },
                          child: Text("Sign Up"),
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
