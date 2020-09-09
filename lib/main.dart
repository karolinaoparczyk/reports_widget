import 'package:flutter/material.dart';
import 'package:reportswidget/reports_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color colorApp = Color(0xffff6e40);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reports',
      theme: ThemeData(
        primaryColor: colorApp,
        accentColor: colorApp,
      ),
      home: ReportsWidget(colorApp: colorApp),
    );
  }
}