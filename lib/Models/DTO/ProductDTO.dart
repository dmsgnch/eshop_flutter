import 'package:eshop/Models/Domain/Product.dart';

import 'Abstract/DTOObjectBase.dart';

class ProductDTO implements DTOObjectBase {
  @override
  late String id;

  late String imageURL;

  late String name;
  late String description;
  late double pricePerUnit;
  late double weightInGrams;
  late double wholesalePricePerUnit;
  late int inStock;
  late double wholesaleQuantity;

  ProductDTO(
      this.imageURL,
      this.name,
      this.description,
      this.pricePerUnit,
      this.weightInGrams,
      this.wholesalePricePerUnit,
      this.inStock,
      this.wholesaleQuantity,
      {this.id = '00000000-0000-0000-0000-000000000000'});

  factory ProductDTO.fromJson(Map<String, Object?> jsonMap) {
    return ProductDTO(
        id: jsonMap["productId"] as String,
        jsonMap["imageURL"] as String,
        jsonMap["name"] as String,
        jsonMap["description"] as String,
        (jsonMap["pricePerUnit"] is int)
            ? (jsonMap["pricePerUnit"] as int).toDouble()
            : jsonMap["pricePerUnit"] as double,
        (jsonMap["weightInGrams"] is int)
            ? (jsonMap["weightInGrams"] as int).toDouble()
            : jsonMap["weightInGrams"] as double,
        (jsonMap["wholesalePricePerUnit"] is int)
            ? (jsonMap["wholesalePricePerUnit"] as int).toDouble()
            : jsonMap["wholesalePricePerUnit"] as double,
        jsonMap["inStock"] as int,
        (jsonMap["wholesaleQuantity"] is int)
            ? (jsonMap["wholesaleQuantity"] as int).toDouble()
            : jsonMap["wholesaleQuantity"] as double);
  }

  @override
  Map toJson() => {
        "productId": id,
        "imageURL": imageURL,
        "name": name,
        "description": description,
        "pricePerUnit": pricePerUnit.toString(),
        "weightInGrams": weightInGrams.toString(),
        "wholesalePricePerUnit": wholesalePricePerUnit.toString(),
        "inStock": inStock.toString(),
        "wholesaleQuantity": wholesaleQuantity.toString()
      };

  Product ConvertToProduct() {
    return Product(
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDTO &&
          id == other.id &&
          runtimeType == other.runtimeType &&
          description == other.description &&
          name == other.name &&
          pricePerUnit == other.pricePerUnit &&
          weightInGrams == other.weightInGrams &&
          wholesalePricePerUnit == other.wholesalePricePerUnit &&
          inStock == other.inStock &&
          wholesaleQuantity == other.wholesaleQuantity;
}
