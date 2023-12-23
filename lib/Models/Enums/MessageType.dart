enum MessageType {
  Error,
  Warning,
  Info
}

class GetMessageTypeName {
  static String getMessageTypeName(MessageType messageType) {
    switch (messageType) {
      case MessageType.Error:
        return 'Error';
      case MessageType.Warning:
        return 'Warning';
      case MessageType.Info:
        return 'Info';
      default:
        throw Exception("Message type not implemented");
    }
  }
}
