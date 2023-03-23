import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/pages/auth/register.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/services/database_service.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/shared/functions.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';
import 'package:flutter_chat_app/widgets/custom_snackbar.dart';
import 'package:flutter_chat_app/widgets/custom_textformfield.dart';

import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  bool _isLoading = false;

  String _email = "";
  String _password = "";

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await authService.loginWithEmailAndPassword(_email, _password).then(
        (value) async {
          if (value == true) {
            QuerySnapshot snapShot = await DatabaseService(
              uid: FirebaseAuth.instance.currentUser!.uid,
            ).gettingUserData(_email);

            // save the shared preferences state
            await HelperFunctions.saveUserLoggedInStatus(true);
            await HelperFunctions.saveUserEmailSF(_email);
            await HelperFunctions.saveUserNameSF(
              snapShot.docs[0]['fullName'],
            );

            // save the data to shared preferences
            await

                // ignore: use_build_context_synchronously
                nextScreen(
              context,
              pageName: const HomePage(),
              replace: true,
            );
          } else {
            setState(() => _isLoading = false);
            showSnackBar(
              context,
              message: value,
              color: Colors.red,
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppColors().primaryColor),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Groupie",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Login now to see whats happenning in your groups",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Image.asset(
                        "assets/login.png",
                      ),
                      CustomTextFormField(
                        label: "Email",
                        prefixIcon: const Icon(Icons.email),
                        prefixIconColor: Theme.of(context).primaryColor,
                        onChanged: (email) => setState(() => _email = email!),
                        validator: (email) => emailValidatorRegex.hasMatch(email!) ? null : "Please enter a valid email",
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        label: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: Theme.of(context).primaryColor,
                        obscureText: true,
                        onChanged: (password) => setState(() => _password = password!),
                        validator: (password) {
                          if (password!.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        btnText: "Sign In",
                        onPressed: () => login(),
                        borderRaduis: 18,
                      ),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                            text: "Dont have an account?",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: " Register here",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (() {
                                    nextScreen(
                                      context,
                                      pageName: const RegisterPage(),
                                      replace: true,
                                    );
                                  }),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
