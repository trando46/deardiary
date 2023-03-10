import 'package:deardiary/models/journalentry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:deardiary/pages/privacy_page.dart';

/***
 * This class is for the settings
 */
class SettingsWidget extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "User: ${user!.email}",
          style: TextStyle(fontSize: 30),
        ),
        // Button to route to the privacy page
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 30),
            backgroundColor: Colors.blueGrey.shade800,
          ),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PrivacyPage())),
          child: const Text('Privacy'),
        ),

        Container(
          height: 15,
        ),

        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 30),
            backgroundColor: Colors.blueGrey.shade800,
          ),
          onPressed: () {}, //Todo: route the user to logout the app
          child: const Text('Logout!'),
        ),
      ],
    );
  }
}
