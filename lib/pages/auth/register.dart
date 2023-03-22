import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/auth/login_page.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/shared/functions.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';
import 'package:flutter_chat_app/widgets/custom_textformfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _name = "";
  String _password = "";

  register() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  "Create an account now to chat and explore",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Image.asset(
                  "assets/login.png",
                ),
                CustomTextFormField(
                  label: "Full Name",
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: Theme.of(context).primaryColor,
                  onChanged: (name) => setState(() => _name = name!),
                  validator: (name) => name!.isNotEmpty && name.length > 3 ? null : "Please enter a valid name",
                ),
                const SizedBox(height: 15),
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
                  btnText: "Register",
                  onPressed: () => register(),
                  borderRaduis: 18,
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "Already have an account?",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: " Login here",
                        recognizer: TapGestureRecognizer()
                          ..onTap = (() {
                            nextScreen(
                              context,
                              pageName: const LoginPage(),
                              replace: true,
                            );
                          }),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
