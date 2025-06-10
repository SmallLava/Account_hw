import 'package:account_hw/controller/speech_service.dart';
import 'package:account_hw/controller/gemini_service.dart';
import 'package:account_hw/controller/record_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/transaction.dart';
import 'view/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      home:
      ChangeNotifierProvider(
        create: (_) => RecordService(),
        child: HomePage(),
      ),
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
  final SpeechService _speech = SpeechService();
  final GeminiService _gemini = GeminiService();
  int _currentIndex = 0;

  List<Widget> get _pages => [Homepage(), Transaction()];

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
          String recognizedText = "";

          await showDialog(context: context, builder: (_) => AlertDialog(
            title: Center(child: Text('使用說明')),
            content: Text('請清楚說明包含[時間、行為、花費]的語句'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('開始聆聽'),
              )
            ],
          ));

          _speech.listening((text) async {
            recognizedText = text;

            _speech.stop();

            final confirmed = await showDialog<bool>(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: Text("辨識結果"),
                    content: Text(recognizedText),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text("取消"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text("確認"),
                      ),
                    ],
                  ),
            );
            if (confirmed == true) {
              final output = await _gemini.sendToGemini(recognizedText);
              if(output['title'] == null || output['price'] == null || output['date'] == null || output['isIncome'] == null || output['type'] == null) {
                showDialog(context: context, builder: (_) => AlertDialog(
                  title: Center(child: Text('辨識失敗 請重試')),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('離開'),
                    )
                  ],
                ));
              } else {
                Provider.of<RecordService>(context, listen: false).addCard(
                  date: DateTime.parse(output['date']),
                  name: output['title'],
                  price: output['price'],
                  isIncome: output['isIncome'],
                  type: output['type'],
                );
              }
            }
          });
        },
        child: Icon(Icons.mic),
      ),
      appBar: AppBar(title: Center(child: const Text("Account"))),
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.countertops),
            label: 'counter',
          ),
        ],
      ),
    );
  }
}
