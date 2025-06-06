import 'package:flutter/material.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: HomePage(
            expenses: 1234.56,
            income: 3000.00,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final double expenses;
  final double income;

  HomePage({
    Key? key,
    required this.expenses,
    required this.income,
  }) : super(key: key);

  final Map<String, List<Map<String, dynamic>>> recordsByDate = {
    '2025/06/06': [
      {'type': 'expense', 'item': 'Coffee', 'amount': 80},
      {'type': 'expense', 'item': 'Lunch', 'amount': 150},
      {'type': 'income', 'item': 'Part-time job', 'amount': 500},
    ],
    '2025/06/05': [
      {'type': 'expense', 'item': 'Groceries', 'amount': 320},
      {'type': 'expense', 'item': 'Transport', 'amount': 60},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> sortedDates = recordsByDate.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // 最新日期在上方

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
                  '\$${expenses.toStringAsFixed(2)}',
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
                  '\$${income.toStringAsFixed(2)}',
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

        // 🔽 記錄清單（每日一個Container）
        Expanded(
          child: ListView.builder(
            itemCount: sortedDates.length,
            itemBuilder: (context, index) {
              final date = sortedDates[index];
              final records = recordsByDate[date]!;

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
                      date,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(thickness: 1.5),

                    // 記錄清單
                    ...records.map((record) {
                      final isExpense = record['type'] == 'expense';
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          isExpense ? Icons.remove : Icons.add,
                          color: isExpense ? Colors.red : Colors.green,
                        ),
                        title: Text(record['item']),
                        trailing: Text(
                          '${isExpense ? '-' : '+'}\$${record['amount']}',
                          style: TextStyle(
                            color: isExpense ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
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