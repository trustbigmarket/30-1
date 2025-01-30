import 'package:flutter/material.dart';
import '../models/dhikr_data.dart';
import '../widgets/dhikr_card.dart';

class MorningDhikrPage extends StatelessWidget {
  const MorningDhikrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أذكار الصباح'),
      ),
      body: ListView.builder(
        itemCount: DhikrData.morningAdhkar.length,
        itemBuilder: (context, index) {
          final dhikr = DhikrData.morningAdhkar[index];
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