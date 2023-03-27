import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/pages/auth/login_page.dart';
import 'package:flutter_chat_app/pages/home/home_page.dart';
import 'package:flutter_chat_app/pages/profile/profile.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/shared/functions.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key, required this.pageName});

  final String pageName;
  // final AuthService authService;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  AuthService authService = AuthService();

  String _userName = "";
  String _email = "";
  String _selectedTabName = "";

  @override
  void initState() {
    getUserData();

    _setSelectedTabColor(sectionText: widget.pageName);
    super.initState();
  }

  getUserData() async {
    await HelperFunctions.getUserLoggedInStatusFromSF().then((value) => setState(() {}));
    await HelperFunctions.getUserEmailFromSF().then((value) => setState(() => _email = value!));
    await HelperFunctions.getUserNameFromSF().then((value) => setState(() => _userName = value!));
  }

  _setSelectedTabColor({required String sectionText}) {
    setState(() => _selectedTabName = sectionText);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {
              _setSelectedTabColor(sectionText: "Groups");
              nextScreen(
                context,
                pageName: const HomePage(),
                replace: true,
              );
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: _selectedTabName == "Groups" ? true : false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(
              Icons.group,
              color: _selectedTabName == "Groups" ? Theme.of(context).primaryColor : Colors.grey,
            ),
            title: Text(
              "Groups",
              style: TextStyle(
                color: _selectedTabName == "Groups" ? Theme.of(context).primaryColor : Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(
                context,
                pageName: const ProfilePage(),
                replace: true,
              );
            },
            selectedColor: _selectedTabName == "Profile" ? Theme.of(context).primaryColor : Colors.grey,
            selected: _selectedTabName == "Profile" ? true : false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.person),
            title: Text(
              "Profile",
              style: TextStyle(
                color: _selectedTabName == "Profile" ? Theme.of(context).primaryColor : Colors.black,
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
    );
  }
}
