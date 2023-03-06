import 'package:deardiary/models/journalentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';


class PrivacyPage extends StatelessWidget {

  String message = "We shall not share your data. We will not abuse your information. We are not legally liable if the data is leak to the public. Agreeing to use our app, you shall not sue us for any reasons. You are liable with signing in and out of the app.";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
      ),
      extendBody: true,
      body: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}