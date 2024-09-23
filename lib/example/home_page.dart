import 'package:flutter/material.dart';

extension JapaneseDateTime on DateTime {
  static const List<String> _weekdays = ['月', '火', '水', '木', '金', '土', '日'];
  
  String toJapaneseString() {
    return '$year年${month.toString().padLeft(2, '0')}月${day.toString().padLeft(2, '0')}日(${_weekdays[weekday - 1]})';
  }
  
  String toFormattedString() {
    return '$year ${month.toString().padLeft(2, '0')}:${day.toString().padLeft(2, '0')}';
  }
}
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('日本語日付表示')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateTime.now().toJapaneseString(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              DateTime.now().toFormattedString(),
              style: const TextStyle(fontSize: 24),
            ),
            // extensionなしの時間
            const SizedBox(height: 20),
            Text(
              DateTime.now().toString(),
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}