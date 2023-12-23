import 'package:eshop/Models/DTO/ProductDTO.dart';
import 'package:eshop/Models/ViewModels/ProductView.dart';

class Product {
  late String id;

  late String imageURL;
  late String name;
  late String description;
  late double pricePerUnit;
  late double weightInGrams;
  late double wholesalePricePerUnit;
  late int inStock;
  late double wholesaleQuantity;

  Product(this.imageURL, this.name, this.description, this.pricePerUnit, this.weightInGrams,
      this.wholesalePricePerUnit, this.inStock, this.wholesaleQuantity,
      {this.id = '00000000-0000-0000-0000-000000000000'});

  ProductDTO ConvertToDTO() {
    return ProductDTO(
        id: id,
        imageURL,
        name,
        description,
        pricePerUnit,
        weightInGrams,
        wholesalePricePerUnit,
        inStock,
        wholesaleQuantity);
  }

  ProductView ConvertToView() {
    return ProductView(
        productId: id,
        imageURL,
        name,
        description,
        pricePerUnit,
        weightInGrams,
        wholesalePricePerUnit,
        inStock,
        wholesaleQuantity);
  }
}