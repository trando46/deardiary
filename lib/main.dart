import 'package:deardiary/pages/home_page.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //used for testing purposes.
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  try {
    final userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    print("Signed in with temporary account.");
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        print("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        print("Unknown error.");
    }
  }

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
        primaryColor: Colors.black,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueGrey.shade200,
      ),
    ),
  );
}



