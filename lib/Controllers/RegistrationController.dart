import 'package:eshop/Models/DTO/UserDTO.dart';
import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Interfaces/ISaveController.dart';
import 'package:eshop/Models/ViewModels/UserView.dart';
import 'package:eshop/Views/SimpleDialogView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegistrationController {
  static late final UserDTO userData;
  SimpleDialogView helperView = GetIt.instance.get<SimpleDialogView>();

  late final ISaveController _saveController;

  RegistrationController() {
    _saveController = GetIt.instance.get<ISaveController>();
  }

  void Register(BuildContext context, UserView userView) {
    _saveController.userSavingService
        .AddAsync(userView.ConvertToUser().ConvertToDTO())
        .then((bool result) {
      helperView.DisplayAllMessageInList(context);
      if (result) {
        NavigateToLoginScreen(context);
      }
    })
        .catchError((error) {
 
    });
  }

  void NavigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/authentication');
  }
}
