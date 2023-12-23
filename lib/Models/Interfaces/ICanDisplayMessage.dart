import 'package:flutter/cupertino.dart';

abstract interface class ICanDisplayMessage {
  void DisplayInfoMessage(String message);
  void DisplayErrorMessage(String message);  
}