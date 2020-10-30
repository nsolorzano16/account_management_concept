import 'package:account_management_app/models/transaction_model.dart';

class DataTransactions {
  static List<TransactionModel> getTransactions() => List.generate(
        20,
        (index) => TransactionModel(
          amount: (14.47 * index),
          firstName: 'Andrzej',
          lastName: 'Broniki',
          time: '2:30 PM',
        ),
      );
}
