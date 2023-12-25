import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfileController {
  late final Function updateListFunction;
  
  void SetUpdateFunction(Function updateFunction) {
    updateListFunction = updateFunction;
  }

  void NavigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/authentication');
  }
}