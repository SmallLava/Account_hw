import '../model/recordcard.dart';

class recordService {
  final List<RecordCard> _record = [
    RecordCard(dateTime: DateTime.now(), name: "Coffee", price: 100, isIncome: false, type: "Drink"),
  ];

  List<RecordCard> get record => _record;
}