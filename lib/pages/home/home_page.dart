import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/pages/auth/login_page.dart';
import 'package:flutter_chat_app/pages/profile/profile.dart';
import 'package:flutter_chat_app/pages/search/search_page.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/services/database_service.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/shared/functions.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';
import 'package:flutter_chat_app/widgets/custom_drawer.dart';
import 'package:flutter_chat_app/widgets/custom_snackbar.dart';
import 'package:flutter_chat_app/widgets/custom_textformfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();

  String _userName = "";
  String _email = "";
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    await HelperFunctions.getUserLoggedInStatusFromSF().then((value) => setState(() {}));
    await HelperFunctions.getUserEmailFromSF().then((value) => setState(() => _email = value!));
    await HelperFunctions.getUserNameFromSF().then((value) => setState(() => _userName = value!));

    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserGroups().then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
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
      drawer: const AppDrawer(pageName: "Groups"),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => popUpDialog(context),
        backgroundColor: AppColors().primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.only(top: 10, bottom: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Create a group",
            textAlign: TextAlign.left,
          ),
          actions: [
            CustomButton(
              btnText: "CANCEL",
              onPressed: () => pop(context),
              btnWidth: MediaQuery.of(context).size.width * 0.3,
            ),
            CustomButton(
              btnText: "CREATE",
              onPressed: () {
                if (groupName != "") {
                  setState(() => _isLoading = true);
                  final userId = FirebaseAuth.instance.currentUser!.uid;
                  DatabaseService(uid: userId).createGroup(_userName, userId, groupName).whenComplete(
                        () => setState(() => _isLoading = false),
                      );

                  pop(context);
                  showSnackBar(
                    context,
                    message: "Group created successfully",
                    color: Colors.green,
                  );
                }
              },
              btnWidth: MediaQuery.of(context).size.width * 0.3,
            ),
          ],
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : CustomTextFormField(
                        borderRadius: 20,
                        onChanged: (value) {
                          setState(() => groupName = value!);
                        },
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return const Text("Hello");
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        }
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => popUpDialog(context),
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "You have not joined any group. Tap on the add icon to join a group or search from the top icon",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
