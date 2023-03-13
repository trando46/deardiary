import 'package:deardiary/models/journalentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:deardiary/pages/privacy_page.dart';
import 'package:provider/provider.dart';
import 'package:deardiary/providers/firestore_provider.dart';


/***
 * This class is for the settings
 */
class SettingsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    final fsp = Provider.of<FirestoreProvider>(context, listen: false);
    final user = fsp.fireauth.currentUser!;
    return ListView(
      children: [
        Text(
          "User: ${user.email}",
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
          onPressed: () {
            showDialog(
                context: context, builder: (context) => signOut(context));
          },
          child: const Text('Logout!'),
        ),
      ],
    );
  }

  Widget signOut(BuildContext context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () async {
              final fsp = Provider.of<FirestoreProvider>(context, listen: false);
              await fsp.fireauth.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            child: const Text('Sign Out'),
          ),
        ],
      );
}
