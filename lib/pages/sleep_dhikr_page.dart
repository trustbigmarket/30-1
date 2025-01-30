import 'package:flutter/material.dart';
import '../models/dhikr_data.dart';
import '../widgets/dhikr_card.dart';

class SleepDhikrPage extends StatelessWidget {
  const SleepDhikrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أذكار النوم'),
      ),
      body: ListView.builder(
        itemCount: DhikrData.sleepAdhkar.length,
        itemBuilder: (context, index) {
          final dhikr = DhikrData.sleepAdhkar[index];
          return DhikrCard(
            text: dhikr['text'],
            description: dhikr['description'],
            reference: dhikr['reference'],
            count: dhikr['count'],
          );
        },
      ),
    );
  }
}