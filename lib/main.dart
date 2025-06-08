import 'package:account_hw/controller/SpeechService.dart';
import 'package:account_hw/controller/gemini_connect.dart';
import 'package:account_hw/controller/record_Service.dart';
import 'package:flutter/material.dart';
import 'view/transaction.dart';
import 'view/home_page.dart';

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
  final GeminiService _gemini = GeminiService();
  int _currentIndex = 0;

  List<Widget> get _pages => [
    Homepage(),
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
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text("正在辨識語音..."),
                ],
              ),
            ),
          );
          await Future.delayed(Duration(milliseconds: 200));
          _speech.listening((text) async {
            Navigator.of(context).pop();

            if (text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("語音辨識為空，請再試一次")),
              );
              return;
            }

            try {
              final output = await _gemini.sendToGemini(text);
              _record.addCard(
                date: DateTime.parse(output['date']),
                name: output['name'],
                price: output['price'],
                isIncome: output['isIncome'],
                type: output['type'],
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("記錄已新增")),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("處理失敗：$e")),
              );
            }
          });
        },
        child: Icon(Icons.mic),
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