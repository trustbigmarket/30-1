import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbeehPage extends StatefulWidget {
  const TasbeehPage({super.key});

  @override
  State<TasbeehPage> createState() => _TasbeehPageState();
}

class _TasbeehPageState extends State<TasbeehPage> {
  int _counter = 0;
  String _currentDhikr = 'سبحان الله';
  final List<String> _dhikrList = [
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
    'لا حول ولا قوة إلا بالله',
    'استغفر الله',
  ];

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('tasbeeh_counter') ?? 0;
      _currentDhikr = prefs.getString('current_dhikr') ?? 'سبحان الله';
    });
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbeeh_counter', _counter);
    await prefs.setString('current_dhikr', _currentDhikr);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _saveCounter();
    // اهتزاز خفيف عند كل تسبيحة
    HapticFeedback.lightImpact();
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    _saveCounter();
  }

  void _shareDhikr() {
    Share.share('لقد سبحت $_currentDhikr $_counter مرة - تطبيق أذكار');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسبيح'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareDhikr,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: _currentDhikr,
              isExpanded: true,
              items: _dhikrList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _currentDhikr = newValue;
                    _counter = 0;
                  });
                  _saveCounter();
                }
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _incrementCounter,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _counter.toString(),
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _currentDhikr,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetCounter,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}