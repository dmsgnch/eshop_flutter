
import 'package:eshop/Models/Domain/CartItem.dart';

class Cart {
  List<CartItem> CartItems = [];
  
  double get TotalPrice => CartItems.fold(0, (sum, item) => sum + item.itemPrice);
}