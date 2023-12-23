import 'package:eshop/Models/Domain/User.dart';

import '../Enums/AccountType.dart';
import 'Abstract/DTOObjectBase.dart';

class UserDTO implements DTOObjectBase {

  @override
  late String id;
  
  late String name;
  late String password;
  late String email;
  late AccountType accountType;

  UserDTO(this.name, this.password, this.email, this.accountType,
      {this.id = '00000000-0000-0000-0000-000000000000'});

  factory UserDTO.fromJson(Map<String, Object?> jsonMap) {
    return UserDTO(
      id: jsonMap["userId"] as String,
      jsonMap["name"] as String,
      jsonMap["password"] as String,
      jsonMap["email"] as String,
      JsonAccountTypeSerializeHelper.DeserializeAccountType(
          jsonMap["accountType"] as String),
    );
  }

  @override
  Map toJson() => {
        "userId": id,
        "name": name,
        "password": password,
        "email": email,
        "accountType":
            JsonAccountTypeSerializeHelper.SerializeAccountType(accountType)
      };

  User ConvertToUser() {
    return User(id: id, name, password, email, accountType);
  }
}
