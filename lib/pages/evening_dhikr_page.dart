import 'package:flutter/material.dart';
import '../models/dhikr_data.dart';
import '../widgets/dhikr_card.dart';

class EveningDhikrPage extends StatelessWidget {
  const EveningDhikrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أذكار المساء'),
      ),
      body: ListView.builder(
        itemCount: DhikrData.eveningAdhkar.length,
        itemBuilder: (context, index) {
          final dhikr = DhikrData.eveningAdhkar[index];
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