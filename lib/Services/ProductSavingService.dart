import 'package:eshop/Controllers/ServerSaveController.dart';
import 'package:eshop/Models/DTO/Abstract/DTOObjectBase.dart';
import 'package:eshop/Models/DTO/ProductDTO.dart';
import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Services/Abstract/ISaveService.dart';
import 'package:eshop/Views/SimpleDialogView.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductSavingService implements ISaveService {
  final String apiUrl = 'https://192.168.1.123:44348/';
  final SimpleDialogView _helperView = GetIt.instance.get<SimpleDialogView>();

  ProductSavingService();

  Future<bool> AddAsync(DTOObjectBase product) async {
    const String actionMap = 'product/add';

    final response = await http.post(
      Uri.parse(apiUrl + actionMap),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      _helperView.AddNewMessage(MessageType.Info, "Product added successfully");
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

  Future<bool> DeleteAsync(String productId) async {
    final String actionMap = 'product/delete/$productId';

    final response = await http.delete(
      Uri.parse(apiUrl + actionMap),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      _helperView.AddNewMessage(MessageType.Info, "Product successfully deleted");
      return true;
    }
    else if (response.statusCode == 400) {
      _helperView.AddNewMessage(MessageType.Error, "Product with id: $productId was not found!");
      return false;
    }
    else {
      throw Exception("Something went wrong in server/client interaction");
    }
  }

  Future<bool> UpdateAsync(DTOObjectBase product) async {
    const String actionMap = 'product/update';

    final response = await http.put(
      Uri.parse(apiUrl + actionMap),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      _helperView.AddNewMessage(MessageType.Info, "Product updated successfully");
      return true;
    }
    else if (response.statusCode == 400) {
      _helperView.AddNewMessage(MessageType.Error, "Product with id: ${product.id} was not found!");
      return false;
    }
    else {
      throw Exception("Something went wrong in server/client interaction");
    }
  }
  
  Future<ProductDTO> GetByIdAsync(String productId) async {
    const String actionMap = 'product/getById';

    final response = await http.get(Uri.parse(apiUrl + actionMap));

    if (response.statusCode == 200) {
      return ProductDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<ProductDTO>> GetAllAsync() async {
    const String actionMap = 'product/getAll';

    final response = await http.get(Uri.parse(apiUrl + actionMap));

    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body) as List;
      return parsedJson.map((product) => ProductDTO.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
