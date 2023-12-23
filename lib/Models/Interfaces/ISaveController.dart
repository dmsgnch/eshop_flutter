

import 'package:eshop/Services/ProductSavingService.dart';
import 'package:eshop/Services/UserSavingService.dart';

abstract interface class ISaveController {
  late final ProductSavingService productSavingService;
  late final UserSavingService userSavingService;
}