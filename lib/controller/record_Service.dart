import 'package:flutter/cupertino.dart';

import '../model/recordcard.dart';

class RecordService extends ChangeNotifier {
  final List<RecordCard> _record = [];

  List<RecordCard> get record => _record;

  void addCard({required DateTime date,required String name, required int price, required bool isIncome, required String type}) {
    _record.add(
      RecordCard(dateTime: date, name: name, price: price, isIncome: isIncome, type: type)
    );
    notifyListeners();
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
  //測試List是否成功加入資料用
  List<RecordCard> getAll() => _record;
}