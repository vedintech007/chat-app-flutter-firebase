import 'package:flutter/material.dart';

// void nextScreen({required BuildContext context, required final page}) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => page));
// }

Future<dynamic> nextScreen(BuildContext context, {required dynamic pageName, bool replace = false, dynamic args}) {
  return replace
      ? Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => pageName,
          ),
        )
      : Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageName,
          ),
        );
}

///goes back
void pop(BuildContext context, {dynamic args, bool route = false}) {
  return Navigator.of(context, rootNavigator: route).pop(args);
}
