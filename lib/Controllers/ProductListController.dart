import 'package:eshop/Models/DTO/UserDTO.dart';
import 'package:eshop/Models/Domain/Cart.dart';
import 'package:eshop/Models/Domain/CartItem.dart';
import 'package:eshop/Models/Domain/Product.dart';
import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Models/Interfaces/ISaveController.dart';
import 'package:eshop/Models/ViewModels/ProductView.dart';
import 'package:eshop/Views/SimpleDialogView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductListController {
  final SimpleDialogView _helperView = GetIt.instance.get<SimpleDialogView>();
  late final Function updateListFunction;

  late final ISaveController _saveController;

  ProductListController() {
    _saveController = GetIt.instance.get<ISaveController>();
  }
  
  void SetUpdateFunction(Function updateFunction) {
    updateListFunction = updateFunction;
  }

  void AddProductAsync(BuildContext context, ProductView productView) async {
    await _saveController.productSavingService
        .AddAsync(productView.ConvertToProduct().ConvertToDTO());
    _helperView.DisplayAllMessageInList(context);
    updateListFunction();
  }

  void UpdateProductAsync(BuildContext context, ProductView productView) async {
    await _saveController.productSavingService
        .UpdateAsync(productView.ConvertToProduct().ConvertToDTO());
    _helperView.DisplayAllMessageInList(context);
    updateListFunction();
  }

  void DeleteProductAsync(BuildContext context, String id) async {
    await _saveController.productSavingService
        .DeleteAsync(id);
    _helperView.DisplayAllMessageInList(context);
    updateListFunction();
  }
  
  void AddToCart(BuildContext context, Product product, int quantity) {
    Cart cart = GetIt.instance.get<Cart>();
    if(cart.CartItems.any((ci) => ci.product.id == product.id)) {
      var foundCartItem = cart.CartItems.firstWhere(
              (ci) => ci.product.id == product.id
      );

      foundCartItem.quantity += quantity;
    }
    else {
      cart.CartItems.add(CartItem(
          product, quantity));
    }
    Navigator.of(context).pop();

    _helperView.AddNewMessage(MessageType.Info, "$quantity ${product.name} added to cart");
    _helperView.DisplayAllMessageInList(context);
  }

  Future<List<ProductView>> GetAllProductsAsync() async {
    return (await _saveController.productSavingService.GetAllAsync())
        .map((pr) => pr.ConvertToProduct().ConvertToView())
        .toList();
  }

  void NavigateToMainScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/mainApp');
  }
}
