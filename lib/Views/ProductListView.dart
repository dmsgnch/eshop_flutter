import 'package:eshop/Controllers/ProductListController.dart';
import 'package:eshop/Models/Domain/Product.dart';
import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Enums/AccountType.dart';
import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Models/ViewModels/MessageView.dart';
import 'package:eshop/Models/ViewModels/ProductView.dart';
import 'package:eshop/Views/AddToCartView.dart';
import 'package:eshop/Views/DialogConfirmView.dart';
import 'package:eshop/Views/GetProductDataView.dart';
import 'package:eshop/Views/ProductInfoView.dart';
import 'package:eshop/main.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductListView extends StatefulWidget {
  final MyHomePageState myHomePageState;

  const ProductListView({Key? key, required this.myHomePageState})
      : super(key: key);

  @override
  ProductListWidgetState createState() => ProductListWidgetState();
}

class ProductListWidgetState extends State<ProductListView> {
  final ProductListController productListController = ProductListController();
  List<ProductView> products = [];

  bool isLoading = false;

  void UpdateProducts() async {
    productListController.GetAllProductsAsync().then((result) {
      setState(() {
        products = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    productListController.GetAllProductsAsync().then((result) {
      setState(() {
        products = result;
        isLoading = false;
      });
    });

    productListController.SetUpdateFunction(UpdateProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 27, 31, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 39, 42, 1),
        title: const Text('Catalog', style: TextStyle(color: Colors.grey)),
        actions: [
          if (GetIt.instance.get<User>().accountType == AccountType.Manager)
            IconButton(
              icon: const Icon(Icons.add, color: Colors.grey),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return GetProductDataView(
                        title: "Add product",
                        function: productListController.AddProductAsync,
                        myContext: context);
                  },
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.update, color: Colors.grey),
            onPressed: UpdateProducts,
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Кількість елементів в рядку
                  crossAxisSpacing: 8.0, // Відступи між елементами в рядку
                  mainAxisSpacing: 8.0, // Відступи між рядками
                  childAspectRatio:
                      0.6, // Співвідношення ширини до висоти елемента
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return BuildProductActions(
                          products[index], productListController, context);
                    },
                  );
                },
              ),
      ),
    );
  }

  Widget BuildProductActions(ProductView product,
      ProductListController productListController, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color.fromRGBO(28, 32, 36, 1)),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 6,
            child: Image.asset(
              product.imageURL,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                    "assets/images/ProductImages/defaultProductIcon.png");
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return ProductInfoView(
                          myContext: context,
                          productView: product,
                          editFunc: productListController.UpdateProductAsync,
                          delFunc: productListController.DeleteProductAsync,
                          addToCartFunc: AddToCart);
                    },
                  );
                },
                child: Text(
                  product.name,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                product.description,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Flexible(
              flex: 3,
              child: GetIt.instance.get<User>().accountType ==
                      AccountType.Customer
                  ? CustomerButtons(context, product, productListController)
                  : ManagerButtons(context, product, productListController)),
        ],
      ),
    );
  }

  Widget CustomerButtons(BuildContext context, ProductView product,
      ProductListController productListController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "${product.pricePerUnit.toString()} грн",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.centerRight,
            child: InkWell(
              child: Image.asset("assets/images/cartImage.png"),
              onTap: () {
                AddToCart(context, product);
              },
            ),
          ),
        ),
      ],
    );
  }

  ManagerButtons(context, product, productListController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 6,
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${product.pricePerUnit.toString()} грн",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${product.wholesalePricePerUnit.toString()} грн",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
                height: 30,
                //alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return GetProductDataView(
                            myContext: context,
                            title: "Edit product",
                            productView: product,
                            function: productListController.UpdateProductAsync);
                      },
                    );
                  },
                ),
              ),
              Container(
                width: 30,
                height: 30,
                //alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    DialogConfirmView dialogConfirmView = DialogConfirmView();
                    dialogConfirmView.ShowProductDialog(
                        context,
                        Message(MessageType.Warning,
                            "Are you sure you want to delete this product?"),
                        product.productId,
                        productListController.DeleteProductAsync);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> AddToCart(BuildContext context, ProductView product) async {
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddToCartView(
            myContext: context,
            productView: product,
            title: "Add product to cart",
            func: productListController.AddToCart);
      },
    );
  }
}
