import 'package:brew_crew/screens/authentication/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return Home or Authenticate widget
    return Authenticate();
  }
}
