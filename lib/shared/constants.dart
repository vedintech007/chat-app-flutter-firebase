import 'package:flutter/material.dart';

class Constants {
  static String appId = "1:1086932682925:web:9b0c981d5ef81aab5a9e24";
  static String apiKey = "AIzaSyDA7PebuLQHEaOil_HebfscVqlKIB1bRSI";
  static String messagingSenderId = "1086932682925";
  static String projectId = "ved-group-chat";
}

class AppColors {
  final primaryColor = const Color(0xFFee7b64);
  final primaryRedColor = const Color(0xFFF12800);
}

var emailValidatorRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
