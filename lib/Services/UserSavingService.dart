import 'package:eshop/Controllers/ServerSaveController.dart';
import 'package:eshop/Models/DTO/Abstract/DTOObjectBase.dart';
import 'package:eshop/Models/DTO/UserDTO.dart';
import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Models/Interfaces/ISaveController.dart';
import 'package:eshop/Services/Abstract/ISaveService.dart';
import 'package:eshop/Views/SimpleDialogView.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserSavingService implements ISaveService {
  final String apiUrl = 'https://192.168.1.123:44348/';
  final SimpleDialogView _helperView = GetIt.instance.get<SimpleDialogView>();

  UserSavingService();

  Future<bool> AddAsync(DTOObjectBase user) async {
    const String actionMap = 'user/add';

    final response = await http.post(
      Uri.parse(apiUrl + actionMap),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      _helperView.AddNewMessage(MessageType.Info, "User added successfully");
      return true;
    } 
    else if (response.statusCode == 400) {
      _helperView.AddNewMessage(MessageType.Error, response.body);
      return false;
    } 
    else {
      throw Exception("Something went wrong in saving data");
    }
  }

  Future<bool> DeleteAsync(String userId) async {
    final String actionMap = 'user/delete/$userId';

    final response = await http.delete(
      Uri.parse(apiUrl + actionMap),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      _helperView.AddNewMessage(MessageType.Info, "User added deleted");
      return true;
    } 
    else if (response.statusCode == 404) {
      _helperView.AddNewMessage(MessageType.Error, "User with id: $userId was not found!");
      return false;
    } 
    else {
      throw Exception("Something went wrong in server/client interaction");
    }
  }

  Future<bool> UpdateAsync(DTOObjectBase user) async {
    const String actionMap = 'user/update';

    final response = await http.put(
      Uri.parse(apiUrl + actionMap),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      _helperView.AddNewMessage(MessageType.Info, "User updated successfully");
      return true;
    } 
    else if (response.statusCode == 404) {
      _helperView.AddNewMessage(MessageType.Error, "User with id: ${user.id} was not found!");
      return false;
    } 
    else {
      throw Exception("Something went wrong in server/client interaction");
    }
  }

  Future<UserDTO> GetByIdAsync(String productId) async {
    const String actionMap = 'user/getById';

    final response = await http.get(Uri.parse(apiUrl + actionMap));

    if (response.statusCode == 200) {
      return UserDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<UserDTO>> GetAllAsync() async {
    try {
      const String actionMap = 'user/getAll';
      final response = await http.get(
        Uri.parse(apiUrl + actionMap)
      );

      if (response.statusCode == 200) {
        final parsedJson = jsonDecode(response.body) as List;

        return parsedJson
            .map((item) => UserDTO.fromJson(item))
            .toList();
      } else {
        throw Exception(
            'Failed to load users. Status code: ${response.statusCode}');
      }
    }
    catch(e) {
      throw Exception(e.toString());
    }
  }
}
