import 'package:eshop/Models/DTO/UserDTO.dart';
import 'package:eshop/Models/Enums/AccountType.dart';
import 'package:eshop/Models/ViewModels/UserView.dart';

class User {
  late String id;

  late String name;
  late String password;
  late String email;
  late AccountType accountType;

  User(this.name, this.password, this.email, this.accountType,
      {this.id = '00000000-0000-0000-0000-000000000000'});

  User.empty() : this('DefaultName', 'DefaultPassword', 'DefaultEmail', AccountType.Customer);

  UserDTO ConvertToDTO() {
    return UserDTO(
        id: id,
        name,
        password,
        email,
        accountType);
  }

  UserView ConvertToView() {
    return UserView(
        userId: id,
        name,
        password,
        email,
        accountType);
  }
}