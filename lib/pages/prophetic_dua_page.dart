import 'package:flutter/material.dart';
import '../models/dhikr_data.dart';
import '../widgets/dhikr_card.dart';

class PropheticDuaPage extends StatelessWidget {
  const PropheticDuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأدعية النبوية'),
      ),
      body: ListView.builder(
        itemCount: DhikrData.propheticDuas.length,
        itemBuilder: (context, index) {
          final dhikr = DhikrData.propheticDuas[index];
          return DhikrCard(
            text: dhikr['text'],
            description: dhikr['description'],
            reference: dhikr['reference'],
            count: dhikr['count'] ?? 1,
          );
        },
      ),
    );
  }
}