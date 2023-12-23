class JsonAccountTypeSerializeHelper {
  static String SerializeAccountType(AccountType accountType) {
    return accountType.toString().split('.').last;
  }

  static AccountType DeserializeAccountType(String accountTypeString) {
    return AccountType.values.firstWhere((e) => e.toString().split('.').last == accountTypeString);
  }
}

enum AccountType {
  Customer,
  Manager,
}

