import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_calculator_flutter/simple_calculator_flutter.dart';



class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          centerTitle: true,
        ),

        body:  Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // 圓角設為 0，變成方形
                      ),
                    ),
                    icon: Icon(	Icons.arrow_downward),
                    label: Text("Income", style: TextStyle(fontSize: 25, color: Colors.green)),
                    onPressed: () {
                      // 執行動作
                    },
                  ),
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // 圓角設為 0，變成方形
                      ),
                    ),
                    icon: Icon(Icons.arrow_upward),
                    label: Text("Expense", style: TextStyle(fontSize: 25, color: Colors.red)),
                    onPressed: () {
                      // 執行動作
                    },
                  ),
                )
              ]
            ),
            Gap(20),
            Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(	Icons.account_balance_wallet),
                      label: Text("Salary"),
                      onPressed: () {
                        // 執行動作
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.trending_up),
                      label: Text("Stock"),
                      onPressed: () {
                        // 執行動作
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.home),
                      label: Text("Passive"),
                      onPressed: () {
                        // 執行動作
                      },
                    ),
                  )
                ]
            ),
            Gap(10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Money',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ]
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),

            Flexible(
              child: Calculator(
                backgroundColour: Colors.grey[200]!,
                operationButtonColor: Colors.orange,
                buttonColor: Colors.blueGrey,
                buttonTextColor: Colors.white,
                operationButtonTextColor: Colors.black,
                resultTextColor: Colors.black45,
              ),
            )


          ]
        )
      );
  }
}