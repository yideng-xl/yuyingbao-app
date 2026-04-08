import 'package:flutter/material.dart';

class YuyingbaoApp extends StatelessWidget {
  const YuyingbaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '育婴宝',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFFFFB74D),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('育婴宝')),
      ),
    );
  }
}
