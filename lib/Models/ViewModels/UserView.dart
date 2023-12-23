import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Enums/AccountType.dart';
import 'package:flutter/cupertino.dart';

class UserView {
  late String userId;

  late String name;
  late String password;
  late String passwordConfirm;
  late String email;
  late AccountType accountType;

  UserView(this.name, this.password, this.email, this.accountType,
      {this.userId = '00000000-0000-0000-0000-000000000000', this.passwordConfirm = ""});

  UserView.empty() : this('DefaultName', 'DefaultPassword', 'DefaultEmail', AccountType.Customer);

  User ConvertToUser() {
    return User(id: userId, name, password, email, accountType);
  }
}
