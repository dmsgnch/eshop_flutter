import 'package:eshop/Models/Domain/Product.dart';

class ProductView {
  late String productId;

  late String imageURL;
  late String name;
  late String description;
  late double pricePerUnit;
  late double weightInGrams;
  late double wholesalePricePerUnit;
  late int inStock;
  late double wholesaleQuantity;

  ProductView(this.imageURL, this.name, this.description, this.pricePerUnit, this.weightInGrams,
      this.wholesalePricePerUnit, this.inStock, this.wholesaleQuantity,
      {this.productId = '00000000-0000-0000-0000-000000000000'});

  ProductView.empty() : this('DefaultUrl', 'DefaultName', 'DefaultDescription', 0.0, 0.0, 0.1, 0, 0.1);

  Product ConvertToProduct() {
    return Product(  id: productId,
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