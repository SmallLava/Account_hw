import '../model/recordcard.dart';

class RecordService {
  final List<RecordCard> _record = [
    RecordCard(dateTime: DateTime.now(), name: "Coffee", price: 100, isIncome: false, type: "Drink"),
    RecordCard(dateTime: DateTime.now(), name: "Lunch", price: 200, isIncome: false, type: "Food"),
    RecordCard(dateTime: DateTime.now(), name: "Salary", price: 1000, isIncome: true, type: "Salary"),
  ];

  List<RecordCard> get record => _record;

  void addCard({required DateTime date,required String name, required int price, required bool isIncome, required String type}) {
    _record.add(
      RecordCard(dateTime: date, name: name, price: price, isIncome: isIncome, type: type)
    );
  }

  int getIncome() {
    int sum = 0;
    for(final r in record) {
      if(r.isIncome) {
        sum += r.price;
      }
    }
    return sum;
  }

  int getExpense() {
    int sum = 0;
    for(final r in record) {
      if(!r.isIncome) {
        sum += r.price;
      }
    }
    return sum;
  }
}