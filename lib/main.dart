import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/morning_dhikr_page.dart';
import 'pages/evening_dhikr_page.dart';
import 'pages/sleep_dhikr_page.dart';
import 'pages/prophetic_dua_page.dart';
import 'pages/ruqyah_page.dart';
import 'pages/tasbeeh_page.dart';
import 'pages/favorites_page.dart';
import 'services/prayer_times_service.dart';
import 'providers/favorites_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PrayerTimesService _prayerTimesService = PrayerTimesService();
  Map<String, String> _prayerTimes = {
    'الفجر': '--:--',
    'الشروق': '--:--',
    'الظهر': '--:--',
    'العصر': '--:--',
    'المغرب': '--:--',
    'العشاء': '--:--',
  };

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
  }

  Future<void> _loadPrayerTimes() async {
    final times = await _prayerTimesService.getPrayerTimes();
    setState(() {
      _prayerTimes = times;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesPage()),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadPrayerTimes,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // مربع مواقيت الصلاة
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(51),  // 0.2 * 255 ≈ 51
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'مواقيت الصلاة',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: _loadPrayerTimes,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _prayerTimes.entries.map((entry) => Column(
                        children: [
                          Text(entry.key),
                          Text(entry.value),
                        ],
                      )).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // رسالة صباحية
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  children: [
                    Text(
                      'صباح الخير يا بابا وربي يحفظك',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('إبدأ يومك بأذكار الصباح'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // الأزرار
              _buildButton(context, 'أذكار الصبح', Colors.amber, Icons.wb_sunny, const MorningDhikrPage()),
              const SizedBox(height: 10),
              _buildButton(context, 'أذكار المساء', Colors.deepPurple, Icons.nights_stay, const EveningDhikrPage()),
              const SizedBox(height: 10),
              _buildButton(context, 'أذكار النوم', Colors.blue, Icons.bed, const SleepDhikrPage()),
              const SizedBox(height: 10),
              _buildButton(context, 'الأدعية النبوية', Colors.green, Icons.book, const PropheticDuaPage()),
              const SizedBox(height: 10),
              _buildButton(context, 'الرقية الشرعية', Colors.teal, Icons.healing, const RuqyahPage()),
              const SizedBox(height: 10),
              _buildButton(context, 'تسبيح', Colors.orange, Icons.favorite, const TasbeehPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, IconData icon, Widget page) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(text),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
