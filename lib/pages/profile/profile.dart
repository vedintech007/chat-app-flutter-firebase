import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/widgets/custom_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  _userName,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  _email,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(pageName: "Profile"),
    );
  }
}
