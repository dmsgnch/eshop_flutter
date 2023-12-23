import 'package:eshop/Controllers/CartController.dart';
import 'package:eshop/Models/Domain/Cart.dart';
import 'package:eshop/Models/Domain/CartItem.dart';
import 'package:eshop/Models/ViewModels/ProductView.dart';
import 'package:eshop/Views/AddToCartView.dart';
import 'package:eshop/Views/ProductInfoView.dart';
import 'package:eshop/main.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CartView extends StatefulWidget {
  final MyHomePageState myHomePageState;

  const CartView({Key? key, required this.myHomePageState}) : super(key: key);

  @override
  CartViewState createState() => CartViewState();
}

class CartViewState extends State<CartView> {
  final CartController cartController = CartController();
  late Cart cart;

  bool _isQuantityValid = false;
  bool isButtonEnabled = true;

  void UpdateCartItems() {
    var myCart = GetIt.instance.get<Cart>();

    setState(() {
      cart = myCart;
    });
  }

  @override
  void initState() {
    super.initState();
    UpdateCartItems();

    cartController.SetUpdateFunction(UpdateCartItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 27, 31, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 39, 42, 1),
        title: const Text('Cart', style: TextStyle(color: Colors.grey)),
        actions: [
          IconButton(
            icon: const Icon(Icons.update, color: Colors.grey),
            onPressed: UpdateCartItems,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cart.CartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cart.CartItems[index];
          return BuildItemsActions(context, cartItem, cartController);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
        color: const Color.fromRGBO(30, 30, 30, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total price: ${cart.TotalPrice}',
                  style: const TextStyle(color: Colors.grey, fontSize: 20)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(33, 39, 42, 1)),
                onPressed: () {
                  cartController.BuyProducts(context);
                  setState(() {
                    cart = Cart();
                  });
                },
                child:
                    const Text('Buy', style: TextStyle(color: Colors.white70, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildItemsActions(
      BuildContext context, CartItem cartItem, CartController cartController) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color.fromRGBO(28, 32, 36, 1)),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return ProductInfoView(
                              myContext: context,
                              productView: cartItem.product.ConvertToView());
                        },
                      );
                    },
                    child: Text(
                      cartItem.product.name,
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Price type: ${cartItem.quantity >= cartItem.product.wholesaleQuantity ? "wholesale" : "normal"}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: 30,
                  height: 30,
                  //alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      AddToCart(context, cartItem.product.ConvertToView());
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quantity: ${cartItem.quantity}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  Price: ${cartItem.itemPrice}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: 30,
                  height: 30,
                  //alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cartController.DeleteProductFromList(
                          context, cartItem.product.id);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void UpdateButtonState() {
    setState(() {
      isButtonEnabled = _isQuantityValid;
    });
  }

  String? QuantityValidate(String? value, CartItem cartItem) {
    if (value == null || value.isEmpty) {
      _isQuantityValid = false;
      return 'Please enter quantity';
    }
    if (int.tryParse(value) == null) {
      _isQuantityValid = false;
      return 'Your quantity is not a number';
    }
    if (double.parse(value) <= 0) {
      _isQuantityValid = false;
      return 'Your price can`t be negative or null';
    }
    if (double.parse(value) > cartItem.product.inStock) {
      _isQuantityValid = false;
      return 'Your price can`t be more than in stock';
    }
    _isQuantityValid = true;
    return null;
  }

  Future<dynamic> AddToCart(BuildContext context, ProductView product) async {
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddToCartView(
            myContext: context,
            productView: product,
            title: "Edit product in cart",
            func: cartController.UpdateProductInList);
      },
    );
  }
}
