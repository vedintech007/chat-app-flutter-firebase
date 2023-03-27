import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/pages/auth/login_page.dart';
import 'package:flutter_chat_app/pages/profile/profile.dart';
import 'package:flutter_chat_app/pages/search/search_page.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/shared/functions.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';

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
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 50),
            children: <Widget>[
              const Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey,
              ),
              const SizedBox(height: 15),
              Text(
                _userName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              ListTile(
                onTap: () {},
                selectedColor: Theme.of(context).primaryColor,
                selected: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.group),
                title: const Text(
                  "Groups",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                onTap: () => nextScreen(context, pageName: const ProfilePage()),
                selectedColor: Theme.of(context).primaryColor,
                selected: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.person),
                title: const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),
                          content: const Text("Are you sure you want to logout?"),
                          actions: [
                            IconButton(
                              onPressed: () => pop(context),
                              icon: const Icon(Icons.cancel, color: Colors.red),
                            ),
                            IconButton(
                              onPressed: () async {
                                authService.signOut().whenComplete(
                                      () => nextScreen(
                                        context,
                                        pageName: const LoginPage(),
                                        replace: true,
                                      ),
                                    );
                              },
                              icon: const Icon(Icons.exit_to_app, color: Colors.green),
                            ),
                          ],
                        );
                      });
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.exit_to_app),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
