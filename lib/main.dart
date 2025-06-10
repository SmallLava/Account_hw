import 'package:account_hw/controller/speech_service.dart';
import 'package:account_hw/controller/gemini_connect.dart';
import 'package:account_hw/controller/record_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/transaction.dart';
import 'view/home_page.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => RecordService(),
    child: MyApp(),
  )
);

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
              Provider.of<RecordService>(context, listen: false).addCard(
              date: DateTime.parse(output['date']),
                name: output['title'],
                price: output['price'],
                isIncome: output['isIncome'],
                type: output['type'],
              );

            }
          });
        },
        child: Icon(Icons.mic),
      ),
      appBar: AppBar(title: const Text("Account")),
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
