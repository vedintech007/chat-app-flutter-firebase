import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/pages/auth/login_page.dart';
import 'package:flutter_chat_app/pages/home/home_page.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/widgets/dismis_keyboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // run the initialization for web
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: Constants.apiKey,
      appId: Constants.appId,
      messagingSenderId: Constants.messagingSenderId,
      projectId: Constants.projectId,
    ));
  } else {
    // run the initialization for mobile
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedin = false;
  @override
  void initState() {
    getUserLoggedInStatus();
    super.initState();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatusFromSF().then((value) {
      if (value != null) {
        setState(() => _isSignedin = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        title: 'Firebase Chat',
        theme: ThemeData(
          primaryColor: AppColors().primaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: _isSignedin ? const HomePage() : const LoginPage(),
      ),
    );
  }
}
