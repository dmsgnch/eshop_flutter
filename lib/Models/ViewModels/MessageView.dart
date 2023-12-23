import 'package:eshop/Models/Enums/MessageType.dart';

class Message {
  late MessageType messageType;
  late String message;
  
  Message(this.messageType, this.message);
}