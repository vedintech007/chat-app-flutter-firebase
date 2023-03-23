import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          btnText: "LOGOUT",
          onPressed: () => authService.signOut(),
        ),
      ),
    );
  }
}
