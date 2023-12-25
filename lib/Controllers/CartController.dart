import 'package:eshop/Models/Domain/Cart.dart';
import 'package:eshop/Models/Domain/CartItem.dart';
import 'package:eshop/Models/Domain/Product.dart';
import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Views/SimpleDialogView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CartController {
  final SimpleDialogView _helperView = GetIt.instance.get<SimpleDialogView>();
  late final Function updateListFunction;

  void SetUpdateFunction(Function updateFunction) {
    updateListFunction = updateFunction;
  }

  void BuyProducts(BuildContext context) {
    _helperView.AddNewMessage(MessageType.Info, "Purchase successfully completed");
    _helperView.DisplayAllMessageInList(context);

    GetIt.instance.get<Cart>().CartItems = [];
    
    updateListFunction();
  }

  void DeleteProductFromList(BuildContext context, String productId) {
    GetIt.instance.get<Cart>().CartItems.removeWhere((ci) => ci.product.id == productId);
    
    _helperView.AddNewMessage(MessageType.Info, "Cart item successfully deleted");
    _helperView.DisplayAllMessageInList(context);
    
    updateListFunction();
  }

  void UpdateProductInList(BuildContext context, Product product, int quantity) {
    Cart cart = GetIt.instance.get<Cart>();
    CartItem cartItem = cart.CartItems.firstWhere(
            (ci) => ci.product.id == product.id);
    cartItem.quantity = quantity;
    
    Navigator.of(context).pop();
    
    _helperView.AddNewMessage(MessageType.Info, "Product quantity successfully changed");
    _helperView.DisplayAllMessageInList(context);

    updateListFunction();
  }
}
