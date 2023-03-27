import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/pages/auth/login_page.dart';
import 'package:flutter_chat_app/pages/profile/profile.dart';
import 'package:flutter_chat_app/pages/search/search_page.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/shared/functions.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';
import 'package:flutter_chat_app/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();

  String _userName = "";
  String _email = "";

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    await HelperFunctions.getUserLoggedInStatusFromSF().then((value) => setState(() {}));
    await HelperFunctions.getUserEmailFromSF().then((value) => setState(() => _email = value!));
    await HelperFunctions.getUserNameFromSF().then((value) => setState(() => _userName = value!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().primaryColor,
        title: const Text(
          "Groups",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(context, pageName: const SearchPage());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors().primaryColor,
        child: const Icon(Icons.add),
      ),
      drawer: const AppDrawer(pageName: "Groups"),
    );
  }
}
