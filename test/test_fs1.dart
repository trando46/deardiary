
//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deardiary/main.dart';
import 'package:deardiary/providers/firestore_provider.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// https://pub.dev/packages/firebase_auth_mocks

import 'package:deardiary/pages/home_page.dart';


void main() async
{
  final mockUser = MockUser(isAnonymous: false, uid: 'mockid', email: 'mock@mock.com', displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp  = FirestoreProvider( FakeFirebaseFirestore(), auth );

  testWidgets(
    'Test MyApp can be created and launches to HomePage',
      (WidgetTester tester) async
      {
        await tester.pumpWidget((MyApp(fsp)));
        expect(find.byType(HomePage), findsOneWidget);
      }
  );
}

