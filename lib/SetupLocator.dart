import 'package:eshop/Controllers/ServerSaveController.dart';
import 'package:eshop/Models/Domain/Cart.dart';
import 'package:eshop/Models/Domain/CartItem.dart';
import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Interfaces/ISaveController.dart';
import 'package:eshop/Services/ProductSavingService.dart';
import 'package:eshop/Services/UserSavingService.dart';
import 'package:eshop/Views/SimpleDialogView.dart';
import 'package:get_it/get_it.dart';

void SetupLocator() { 
  GetIt.instance.registerSingleton<User>(User.empty());
  GetIt.instance.registerSingleton<Cart>(Cart());
  GetIt.instance.registerSingleton<SimpleDialogView>(SimpleDialogView());
  GetIt.instance.registerSingleton<ISaveController>(ServerSaveController());
}