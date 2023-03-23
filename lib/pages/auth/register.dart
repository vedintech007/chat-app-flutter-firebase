import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/pages/auth/login_page.dart';
import 'package:flutter_chat_app/pages/home/home_page.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/shared/functions.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';
import 'package:flutter_chat_app/widgets/custom_snackbar.dart';
import 'package:flutter_chat_app/widgets/custom_textformfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _email = "";
  String _fullName = "";
  String _password = "";

  register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await authService.registerUserWithEmailAndPassword(_fullName, _email, _password).then(
        (value) async {
          if (value == true) {
            // save the shared preferences state
            await HelperFunctions.saveUserLoggedInStatus(true);
            await HelperFunctions.saveUserEmailSF(_email);
            await HelperFunctions.saveUserNameSF(_fullName);
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
                        onChanged: (name) => setState(() => _fullName = name!),
                        validator: (name) => name!.isNotEmpty && name.length > 2 ? null : "Please enter a valid name",
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
