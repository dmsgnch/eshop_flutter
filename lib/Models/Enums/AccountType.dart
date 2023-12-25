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

class GetAccountTypeName {
  static String getAccountTypeName(AccountType accountType) {
    switch (accountType) {
      case AccountType.Customer:
        return 'Customer';
      case AccountType.Manager:
        return 'Manager';
      default:
        throw Exception("Account type not implemented");
    }
  }
}

