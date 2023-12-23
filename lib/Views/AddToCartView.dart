import 'package:eshop/Models/Domain/Cart.dart';
import 'package:eshop/Models/Domain/CartItem.dart';
import 'package:eshop/Models/Domain/Product.dart';
import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Enums/AccountType.dart';
import 'package:eshop/Models/ViewModels/ProductView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AddToCartView extends StatefulWidget {
  final BuildContext myContext;
  final ProductView productView;
  final String title;
  final Function(BuildContext, Product, int) func;

  const AddToCartView({
    Key? key,
    required this.myContext,
    required this.productView,
    required this.title,
    required this.func,
  }) : super(key: key);

  @override
  State<AddToCartView> createState() => _AddToCartViewState();
}

class _AddToCartViewState extends State<AddToCartView> {
  final TextEditingController _quantityController = TextEditingController();
  bool _isQuantityValid = false;
  bool isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    _quantityController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title, style: const TextStyle(fontSize: 20)),
      //backgroundColor: const Color.fromRGBO(21, 27, 31, 1),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 6,
                child: Text(
                    "Product: ${widget.productView.name}\nPlease, select the quantity:\n"),
              ),
              Flexible(
                flex: 1,
                child: TextFormField(
                  controller: _quantityController,
                  //style: const TextStyle(color: Colors.white, fontSize: 16),
                  onChanged: (value) {
                    QuantityValidate(value, widget.productView);
                    UpdateButtonState();
                  },
                  validator: (value) {
                    return QuantityValidate(value, widget.productView);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: "Quantity",
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.bottomRight,
          child: Row(
            children: [
              TextButton(
                onPressed: isButtonEnabled
                    ? () {
                        widget.func(
                            widget.myContext,
                            widget.productView.ConvertToProduct(),
                            int.parse(_quantityController.text));
                        
                      }
                    : null,
                child: const Text('Ok'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        )
      ],
    );
  }

  void UpdateButtonState() {
    setState(() {
      isButtonEnabled = _isQuantityValid;
    });
  }

  String? QuantityValidate(String? value, ProductView product) {
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
    if (double.parse(value) > product.inStock) {
      _isQuantityValid = false;
      return 'Your price can`t be more than in stock';
    }
    _isQuantityValid = true;
    return null;
  }
}
