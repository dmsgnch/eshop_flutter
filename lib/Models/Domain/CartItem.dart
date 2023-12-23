import 'package:eshop/Models/DTO/ProductDTO.dart';
import 'package:eshop/Models/Domain/Product.dart';

class CartItem {
  late Product product;
  late int quantity;
  
  double get itemPrice => 
      quantity >= product.wholesaleQuantity ? 
      product.wholesalePricePerUnit * quantity :
      product.pricePerUnit * quantity;
  
  CartItem(this.product, this.quantity);
}