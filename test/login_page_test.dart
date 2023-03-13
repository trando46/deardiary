import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



import 'package:deardiary/auth_methods.dart';
import 'package:deardiary/widgets/signin_widget.dart';
import 'package:deardiary/pages/authentication_page.dart';

void main() {

  Widget buildTestableWidget(Widget widget) {
    return new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: widget)
    );
  }

  testWidgets('find the sign in button', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the Sign in button
    Finder signInButton = find.byKey(new Key('login'));

    expect(signInButton, findsOneWidget);
  });

  testWidgets('find the register button', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the register button
    Finder signInButton = find.byKey(new Key('Register button'));

    expect(signInButton, findsOneWidget);
  });

  testWidgets('After clicking on the sign in button take you to the sign in dialog', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the Sign in button
    Finder signInButton = find.byKey(new Key('login'));

    expect(signInButton, findsOneWidget);

    // tap on the sign in button
    await tester.tap(signInButton);
    await tester.pump();

    expect(find.byKey(Key('Sign In Dialog')), findsOneWidget);
  });

  testWidgets('After clicking on the register button take you to the register dialog', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the register in button
    Finder registerButton = find.byKey(new Key('Register button'));

    expect(registerButton, findsOneWidget);

    // tap on the register button
    await tester.tap(registerButton);
    await tester.pump();

    expect(find.byKey(Key('Register Dialog')), findsOneWidget);
  });

  testWidgets('find the cancel button in the sign in dialog', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the Sign in button
    Finder signInButton = find.byKey(new Key('login'));

    expect(signInButton, findsOneWidget);

    // tap on the login button
    await tester.tap(signInButton);
    await tester.pump();

    expect(find.byKey(Key('Sign In Dialog')), findsOneWidget);
    
    Finder cancelButton = find.byKey(Key("Sign In Dialog Cancel Button"));
    expect(cancelButton, findsOneWidget);
    
  });

  testWidgets('Fill out the email and password fields', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the Sign in button
    Finder signInButton = find.byKey(new Key('login'));

    expect(signInButton, findsOneWidget);

    // tap on the login button
    await tester.tap(signInButton);
    await tester.pump();

    expect(find.byKey(Key('Sign In Dialog')), findsOneWidget);
    expect(find.byKey(Key('Enter Email')), findsOneWidget);
    expect(find.byKey(Key('Enter Password')), findsOneWidget);

    await tester.enterText(find.byKey(Key('Enter Email')), 'email');
    await tester.enterText(find.byKey(Key('Enter Password')), 'password');
    await tester.pump();

    expect(find.text('email'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);

  });

  testWidgets('Find the cancel button in the register dialog', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the register in button
    Finder registerButton = find.byKey(new Key('Register button'));

    expect(registerButton, findsOneWidget);

    // tap on the register button
    await tester.tap(registerButton);
    await tester.pump();

    expect(find.byKey(Key('Register Dialog')), findsOneWidget);

    // find the register cancel button
    Finder cancelButton = find.byKey(new Key('Register cancel button'));

    expect(cancelButton, findsOneWidget);

  });

  testWidgets('Find the fields in register dialog', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the register in button
    Finder registerButton = find.byKey(new Key('Register button'));

    expect(registerButton, findsOneWidget);

    // tap on the register button
    await tester.tap(registerButton);
    await tester.pump();

    expect(find.byKey(Key('Register Dialog')), findsOneWidget);

    // find the register fields
    expect(find.byKey(Key('Register username')), findsOneWidget);
    expect(find.byKey(Key('Register email')), findsOneWidget);
    expect(find.byKey(Key('Register password')), findsOneWidget);
    expect(find.byKey(Key('Register birth')), findsOneWidget);

  });

  testWidgets('Fill out the fields in register dialog', (WidgetTester tester) async {

    // create the login page
    AuthenticationPage loginPage = new AuthenticationPage();

    // pump widget
    await tester.pumpWidget(buildTestableWidget(loginPage));

    // find the register in button
    Finder registerButton = find.byKey(new Key('Register button'));

    expect(registerButton, findsOneWidget);

    // tap on the register button
    await tester.tap(registerButton);
    await tester.pump();

    expect(find.byKey(Key('Register Dialog')), findsOneWidget);

    // find the register fields
    expect(find.byKey(Key('Register username')), findsOneWidget);
    expect(find.byKey(Key('Register email')), findsOneWidget);
    expect(find.byKey(Key('Register password')), findsOneWidget);
    expect(find.byKey(Key('Register birth')), findsOneWidget);

    // fill out the register fields
    await tester.enterText(find.byKey(Key('Register username')), 'user');
    await tester.enterText(find.byKey(Key('Register email')), 'email');
    await tester.enterText(find.byKey(Key('Register password')), 'password');
    //await tester.enterText(find.byKey(Key('Register birth')), '03/10/2023');
    await tester.pump();

    expect(find.text('user'), findsOneWidget);
    expect(find.text('email'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
    //expect(find.text('03/10/2023'), findsOneWidget);
  });


}