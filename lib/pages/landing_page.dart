import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'authentication_page.dart';

import 'package:provider/provider.dart';
import 'package:deardiary/providers/firestore_provider.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    final fsp = Provider.of<FirestoreProvider>(context, listen: false);
    final muser = fsp.fireauth.currentUser is MockUser;
    return StreamBuilder<User?>(
      stream: fsp.fireauth.authStateChanges(),
      builder: ((context, snapshot) {
        if ((snapshot.connectionState == ConnectionState.active) || (muser)) {
          if ((snapshot.data != null) || (muser)){
            return const HomePage();
          } else {
            return const AuthenticationPage();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }
}
