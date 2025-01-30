import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class PrayerTimesService {
  Future<Map<String, String>> getPrayerTimes() async {
    try {
      // طلب إذن الموقع
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // الحصول على الموقع الحالي
      Position position = await Geolocator.getCurrentPosition();

      // إعداد المعلمات لحساب مواقيت الصلاة
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      final prayerTimes = PrayerTimes.today(coordinates, params);

      // تنسيق الأوقات
      final format = DateFormat.Hm();
      
      return {
        'الفجر': format.format(prayerTimes.fajr),
        'الشروق': format.format(prayerTimes.sunrise),
        'الظهر': format.format(prayerTimes.dhuhr),
        'العصر': format.format(prayerTimes.asr),
        'المغرب': format.format(prayerTimes.maghrib),
        'العشاء': format.format(prayerTimes.isha),
      };
    } catch (e) {
      debugPrint('خطأ في الحصول على مواقيت الصلاة: $e');
      return {
        'الفجر': '--:--',
        'الشروق': '--:--',
        'الظهر': '--:--',
        'العصر': '--:--',
        'المغرب': '--:--',
        'العشاء': '--:--',
      };
    }
  }
}
