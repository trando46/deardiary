import 'package:deardiary/pages/home_page.dart';
import 'package:deardiary/pages/landing_page.dart';
import 'package:deardiary/pages/authentication_page.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'providers/firestore_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //used for testing purposes.
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // try {
  //   final userCredential = await FirebaseAuth.instance.signInAnonymously();
  //   print("Signed in with temporary account.");
  // } on FirebaseAuthException catch (e) {
  //   switch (e.code) {
  //     case "operation-not-allowed":
  //       print("Anonymous auth hasn't been enabled for this project.");
  //       break;
  //     default:
  //       print("Unknown error.");
  //   }
  // }

  runApp(MyApp(FirestoreProvider()));
}

class MyApp extends StatelessWidget {
  static final String title = 'Dear Diary';
  final FirestoreProvider _firestore;
  final JournalEntryProvider jep;

  MyApp(FirestoreProvider firestore) : _firestore = firestore,
  jep = JournalEntryProvider(firestore: firestore);


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: jep),
        Provider.value(value: _firestore)
      ],
      child: MaterialApp(
        home: LandingPage(),
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
}
