import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Models/Interfaces/ISaveController.dart';
import 'package:eshop/Views/SimpleDialogView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../Models/DTO/UserDTO.dart';

class AuthenticationController {
  final String _errorMessage =
      "Username or password is incorrect! Please, try again!";
  static late final UserDTO userData;
  final SimpleDialogView _helperView = GetIt.instance.get<SimpleDialogView>();

  late final ISaveController _saveController;

  AuthenticationController() {
    _saveController = GetIt.instance.get<ISaveController>();
  }
  
  void Authenticate(BuildContext context, String email, String password) async {    
    List<UserDTO> usersDTO = await _saveController.userSavingService.GetAllAsync();
    List<User> users = usersDTO.map((u) => u.ConvertToUser()).toList();
    
    if (IsUserDataCorrect(users, email, password)) {      
      NavigateToMainScreen(context);
    }
    else {
      _helperView.AddNewMessage(MessageType.Error, _errorMessage);
      _helperView.DisplayAllMessageInList(context);
    }
  }
  
  bool IsUserDataCorrect(List<User> users, String email, String password) {
    for(var user in users) {
      if (user.email == email &&
          user.password == password) {
        var myUser = GetIt.instance.get<User>();
        
        myUser.name = user.name;
        myUser.password = user.password;
        myUser.email = user.email;
        myUser.id = user.id;
        myUser.accountType = user.accountType;
        
        return true;
      }
    }
    
    return false;
  }
  
  void NavigateToMainScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/mainApp');
  }
}
