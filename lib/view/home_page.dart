import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:account_hw/controller/record_Service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final RecordService _record = RecordService();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔺 顯示月支出/收入
        Row(
          children: [
            // 左：支出
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Expenses',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _record.getExpense().toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            Expanded(child: SizedBox()),

            // 右：收入
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Monthly Income',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _record.getIncome().toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        // 🔽 記錄清單（每筆資料一個Container）
        Expanded(
          child: ListView.builder(
            itemCount: _record.record.length,
            itemBuilder: (context, index) {

              return Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  border: Border.all(color: Colors.grey.shade600, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 日期
                    Text(
                      DateFormat('yyyy-MM-dd').format(_record.record[index].dateTime),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(thickness: 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _record.record[index].name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_record.record[index].isIncome ? '+' : '-'}\$${_record.record[index].price}',
                          style: TextStyle(
                            color: _record.record[index].isIncome ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
