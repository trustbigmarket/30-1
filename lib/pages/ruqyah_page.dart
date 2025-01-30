import 'package:flutter/material.dart';
import '../models/dhikr_data.dart';
import '../widgets/dhikr_card.dart';

class RuqyahPage extends StatelessWidget {
  const RuqyahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرقية الشرعية'),
      ),
      body: ListView.builder(
        itemCount: DhikrData.ruqyah.length,
        itemBuilder: (context, index) {
          final dhikr = DhikrData.ruqyah[index];
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