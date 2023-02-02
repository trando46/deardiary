import 'package:deardiary/pages/home_page.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static final String title = 'Dear Diary';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => JournalEntryProvider(),
    child: MaterialApp(
      home: HomePage(),
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFFFBE9E7),
      ),
    ),
  );
}



