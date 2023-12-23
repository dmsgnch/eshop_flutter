import 'dart:ui';

import 'package:eshop/Controllers/ProductListController.dart';
import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Enums/AccountType.dart';
import 'package:eshop/Models/ViewModels/ProductView.dart';
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
              Flexible(flex: 1, child: Text(widget.productView.name)),
              Flexible(flex: 1, child: Text(widget.productView.description)),
              Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        child: Text(widget.productView.pricePerUnit.toString()),
                      ),
                      Container(
                        child: Text(widget.productView.wholesalePricePerUnit
                            .toString()),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                if (GetIt.instance
                    .get<User>()
                    .accountType ==
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
              widget.editFunc!(widget.myContext, widget.productView);
              Navigator.of(context).pop();
            },
            child: const Text('Edit'),
          ),
        if (widget.delFunc != null)
          TextButton(
            onPressed: () {
              widget.delFunc!(widget.myContext, widget.productView.productId);
              Navigator.of(context).pop();
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
          widget.addToCartFunc!(widget.myContext, widget.productView);
          Navigator.of(context).pop();
        },
        child: const Text('Add to Cart'),
      ),
    );
  }
}
