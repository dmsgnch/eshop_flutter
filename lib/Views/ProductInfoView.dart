import 'dart:ui';

import 'package:eshop/Controllers/ProductListController.dart';
import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Enums/AccountType.dart';
import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Models/ViewModels/MessageView.dart';
import 'package:eshop/Models/ViewModels/ProductView.dart';
import 'package:eshop/Views/DialogConfirmView.dart';
import 'package:eshop/Views/GetProductDataView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductInfoView extends StatefulWidget {
  final BuildContext myContext;
  final ProductView productView;
  final void Function(BuildContext, ProductView)? editFunc;
  final void Function(BuildContext, String)? delFunc;
  final void Function(BuildContext, ProductView)? addToCartFunc;

  const ProductInfoView({
    Key? key,
    required this.myContext,
    required this.productView,
    this.editFunc,
    this.delFunc,
    this.addToCartFunc,
  }) : super(key: key);

  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  @override
  void initState() {
    super.initState();
    //TODO: Delete
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                child: Image.asset(
                  widget.productView.imageURL,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Image.asset(
                        "assets/images/ProductImages/defaultProductIcon.png");
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Name: ${widget.productView.name}"),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Description: ${widget.productView.description}"),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Weight: ${widget.productView.weightInGrams}"),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Wholesale quantity: ${widget.productView.wholesaleQuantity}"),
                ),
              ),
              if(GetIt.instance.get<User>().accountType ==
                  AccountType.Manager)
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("In stock: ${widget.productView.inStock}"),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Price: ${widget.productView.pricePerUnit.toString()}"),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Wholesale price: ${widget.productView.wholesalePricePerUnit.toString()}"),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        actions: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (GetIt.instance.get<User>().accountType ==
                    AccountType.Manager)
                  DisplayManagerButtons()
                else
                  DisplayCustomerButtons(),
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
      ),
    );
  }

  Widget DisplayManagerButtons() {
    return Row(
      children: [
        if (widget.editFunc != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return GetProductDataView(
                      myContext: widget.myContext,
                      title: "Edit product",
                      productView: widget.productView,
                      function: widget.editFunc!);
                },
              );
            },
            child: const Text('Edit'),
          ),
        if (widget.delFunc != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              DialogConfirmView dialogConfirmView = DialogConfirmView();
              dialogConfirmView.ShowProductDialog(
                  widget.myContext,
                  Message(MessageType.Warning,
                      "Are you sure you want to delete this product?"),
                  widget.productView.productId,
                  widget.delFunc!);
            },
            child: const Text('Delete'),
          ),
      ],
    );
  }

  Widget DisplayCustomerButtons() {
    return Visibility(
      visible: widget.addToCartFunc != null,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          widget.addToCartFunc!(widget.myContext, widget.productView);
        },
        child: const Text('Add to Cart'),
      ),
    );
  }
}
