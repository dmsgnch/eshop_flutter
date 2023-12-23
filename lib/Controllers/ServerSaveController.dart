import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:eshop/Models/Interfaces/ICanDisplayMessage.dart';
import 'package:eshop/Services/Abstract/ISaveService.dart';
import 'package:eshop/Services/ProductSavingService.dart';
import 'package:eshop/Services/UserSavingService.dart';
import 'package:http/http.dart' as http;

import 'package:eshop/Models/Interfaces/ISaveController.dart';

class ServerSaveController implements ISaveController, ICanDisplayMessage {
  //late final ISaveService _productSavingService;
  //late final ISaveService _userSavingService;
  @override
  late final ProductSavingService productSavingService;
  @override
  late final UserSavingService userSavingService;
  
  ServerSaveController() {
    productSavingService = ProductSavingService();
    userSavingService = UserSavingService();
  }

  //ServerSaveController(this.productSavingService, this.userSavingService);

  void DisplayErrorMessage(String errorMessage) {}

  void DisplayInfoMessage(String infoMessage) {}
}
