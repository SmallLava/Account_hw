import 'package:account_hw/controller/SpeechService.dart';
import 'package:account_hw/controller/record_Service.dart';
import 'package:flutter/material.dart';
import 'view/Transaction.dart';
import 'package:intl/intl.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      home: HomePage(),
      theme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RecordService _record = RecordService();
  final SpeechService _speech = SpeechService();
  int _currentIndex = 0;

  List<Widget> get _pages => [
    Column(
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
    ),
    Transaction(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speech.initSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _speech.listening((text) async{

          });
        },
      ),
      appBar: AppBar(title: const Text("Account"),),
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.countertops),
            label: 'counter'
          )
        ],
      ),
    );
  }
}

// Icon(
// isExpense ? Icons.remove : Icons.add,
// color: isExpense ? Colors.red : Colors.green,
// ),