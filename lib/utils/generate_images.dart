import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<void> main() async {
  // تأكد من تهيئة Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // قائمة بالصور التي سننشئها
  final images = {
    'morning_dhikr': Icons.wb_sunny,
    'evening_dhikr': Icons.nights_stay,
    'sleep_dhikr': Icons.bedtime,
    'dua': Icons.favorite,
    'ruqyah': Icons.healing,
    'tasbeeh': Icons.radio_button_unchecked,
    'prayer_times': Icons.access_time,
  };

  // إنشاء كل صورة
  for (var entry in images.entries) {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    
    // رسم خلفية بيضاء
    canvas.drawRect(
      Rect.fromLTWH(0, 0, 200, 200),
      Paint()..color = Colors.white,
    );

    // رسم الأيقونة
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(entry.value.codePoint),
        style: TextStyle(
          fontFamily: entry.value.fontFamily,
          fontSize: 150,
          color: Colors.blue,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (200 - textPainter.width) / 2,
        (200 - textPainter.height) / 2,
      ),
    );

    // حفظ الصورة
    final picture = recorder.endRecording();
    final image = await picture.toImage(200, 200);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    // حفظ الملف
    final file = File('assets/images/${entry.key}.png');
    await file.writeAsBytes(buffer);
  }
}
