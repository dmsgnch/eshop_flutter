import 'package:eshop/Models/ViewModels/ProductView.dart';
import 'package:flutter/material.dart';

class GetProductDataView extends StatefulWidget {
  final BuildContext myContext;
  final String title;
  final ProductView? productView;
  final void Function(BuildContext, ProductView) function;

  const GetProductDataView(
      {Key? key,
      required this.myContext,
      required this.title,
      required this.function,
      this.productView})
      : super(key: key);

  @override
  State<GetProductDataView> createState() => _GetProductDataState();
}

class _GetProductDataState extends State<GetProductDataView> {
  late bool _isNameValid,
      _isDescriptionValid,
      _isPriceValid,
      _isWeightValid,
      _isWholesalePriceValid,
      _isInStockValid,
      _isWholesaleQuantityValid;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _weightController = TextEditingController();
  final _wholesalePriceController = TextEditingController();
  final _inStockController = TextEditingController();
  final _wholesaleQuantityController = TextEditingController();

  late bool isButtonEnabled;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.productView?.name ?? "";
    _descriptionController.text = widget.productView?.description ?? "";
    _priceController.text = widget.productView?.pricePerUnit.toString() ?? "";
    _weightController.text = widget.productView?.weightInGrams.toString() ?? "";
    _wholesalePriceController.text = widget.productView?.wholesalePricePerUnit.toString() ?? "";
    _inStockController.text = widget.productView?.inStock.toString() ?? "";
    _wholesaleQuantityController.text = widget.productView?.wholesaleQuantity.toString() ?? "";

    _isNameValid = widget.productView != null;
    _isDescriptionValid = widget.productView != null;
    _isPriceValid = widget.productView != null;
    _isWeightValid = widget.productView != null;
    _isWholesalePriceValid = widget.productView != null;
    _isInStockValid = widget.productView != null;
    _isWholesaleQuantityValid = widget.productView != null;

    isButtonEnabled = widget.productView != null;
  }

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(widget.title),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                onChanged: (value) {
                  NameValidate(value);
                  UpdateButtonState();
                },
                validator: (value) {
                  return NameValidate(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                onChanged: (value) {
                  DescriptionValidate(value);
                  UpdateButtonState();
                },
                validator: (value) {
                  return DescriptionValidate(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              TextFormField(
                controller: _weightController,
                onChanged: (value) {
                  WeightValidate(value);
                  UpdateButtonState();
                },
                validator: (value) {
                  return WeightValidate(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Weight in grams',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _priceController,
                onChanged: (value) {
                  PriceValidate(value);
                  WholesalePriceValidate(value);
                  UpdateButtonState();
                },
                validator: (value) {
                  return PriceValidate(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Price per unit',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _wholesalePriceController,
                onChanged: (value) {
                  WholesalePriceValidate(value);
                  PriceValidate(value);
                  UpdateButtonState();
                },
                validator: (value) {
                  return WholesalePriceValidate(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Wholesale price',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _wholesaleQuantityController,
                onChanged: (value) {
                  WholesaleQuantityValidate(value);
                  UpdateButtonState();
                },
                validator: (value) {
                  return WholesaleQuantityValidate(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Wholesale quantity',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _inStockController,
                onChanged: (value) {
                  InStockValidate(value);
                  UpdateButtonState();
                },
                validator: (value) {
                  return InStockValidate(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Amount in stock',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: isButtonEnabled
                ? () {
                    ProductView product = ProductView(
                        productId: widget.productView?.productId ??
                            '00000000-0000-0000-0000-000000000000',
                        "image mock",
                        _nameController.text,
                        _descriptionController.text,
                        double.parse(_priceController.text),
                        double.parse(_weightController.text),
                        double.parse(_wholesalePriceController.text),
                        int.parse(_inStockController.text),
                        double.parse(_wholesaleQuantityController.text));

                    widget.function(widget.myContext, product);
                    Navigator.of(context).pop();
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
    );
  }

  void UpdateButtonState() {
    setState(() {
      isButtonEnabled = _isNameValid &&
          _isDescriptionValid &&
          _isPriceValid &&
          _isWeightValid &&
          _isWholesalePriceValid &&
          _isInStockValid &&
          _isWholesaleQuantityValid;
    });
  }
  
  //region Validators

  String? NameValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isNameValid = false;
      return 'Please enter a name';
    }
    if (value.length > 12) {
      _isNameValid = false;
      return 'Name is too long';
    }
    _isNameValid = true;
    return null;
  }

  String? DescriptionValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isDescriptionValid = false;
      return 'Please enter a description';
    }
    if (value.length > 30) {
      _isDescriptionValid = false;
      return 'Description is too long';
    }
    _isDescriptionValid = true;
    return null;
  }

  String? PriceValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isPriceValid = false;
      return 'Please enter a price';
    }
    if (double.tryParse(value) == null) {
      _isPriceValid = false;
      return 'Your price is not a number';
    }
    if (double.parse(value) <= 0) {
      _isPriceValid = false;
      return 'Your price can`t be negative';
    }
    double? wholesalePrice = double.tryParse(_wholesalePriceController.text);
    if (wholesalePrice == null) {
      _isPriceValid = false;
      return 'Wholesale price is incorrect';
    }
    if (wholesalePrice >= double.parse(value)) {
      _isPriceValid = false;
      return 'Wholesale price can`t be greater than price';
    }
    _isPriceValid = true;
    return null;
  }

  String? WeightValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isWeightValid = false;
      return 'Please enter a weight';
    }
    if (double.tryParse(value) == null) {
      _isWeightValid = false;
      return 'Your weight is not a number';
    }
    if (double.parse(value) <= 0) {
      _isWeightValid = false;
      return 'Your weight can`t be negative';
    }
    _isWeightValid = true;
    return null;
  }

  String? WholesalePriceValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isWholesalePriceValid = false;
      return 'Please enter a wholesale price';
    }
    if (double.tryParse(value) == null) {
      _isWholesalePriceValid = false;
      return 'Your wholesale price is not a number';
    }
    if (double.parse(value) <= 0) {
      _isWholesalePriceValid = false;
      return 'Your wholesale price can`t be negative';
    }
    double? price = double.tryParse(_priceController.text);
    if (price == null) {
      _isWholesalePriceValid = false;
      return 'Price is incorrect';
    }
    if (double.parse(value) >= price) {
      _isWholesalePriceValid = false;
      return 'Wholesale price can`t be greater than price';
    }
    _isWholesalePriceValid = true;
    return null;
  }

  String? InStockValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isInStockValid = false;
      return 'Please enter a quantity of product in stock';
    }
    if (int.tryParse(value) == null) {
      _isInStockValid = false;
      return 'Your quantity of product in stock is not a number';
    }
    if (int.parse(value) <= 0) {
      _isInStockValid = false;
      return 'Your quantity of product in stock can`t be negative';
    }
    _isInStockValid = true;
    return null;
  }

  String? WholesaleQuantityValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isWholesaleQuantityValid = false;
      return 'Please enter a wholesale quantity';
    }
    if (double.tryParse(value) == null) {
      _isWholesaleQuantityValid = false;
      return 'Your wholesale quantity is not a number';
    }
    if (double.parse(value) <= 0) {
      _isWholesaleQuantityValid = false;
      return 'Your wholesale quantity can`t be negative';
    }
    _isWholesaleQuantityValid = true;
    return null;
  }
  
  //endregion
}
