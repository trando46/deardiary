// ignore_for_file: use_build_context_synchronously

import 'package:deardiary/widgets/registerUser_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uuid/uuid.dart';

import 'package:provider/provider.dart';
import 'package:deardiary/providers/firestore_provider.dart';

import '../auth_methods.dart';
import '../widgets/signin_widget.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  String userID = '';
  String username = '';
  String dateOfBirth = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Dear Diary"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SignInWidget(
                      onEmailChanged: (email) =>
                          setState(() => this.email = email),
                      onPasswordChanged: (password) =>
                          setState(() => this.password = password),
                      onSignInPressed: login,
                    ),
                  );
                },
                child: const Text("Sign In"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => RegisterUserWidget(
                      onEmailChanged: (email) =>
                          setState(() => this.email = email),
                      onPasswordChanged: (password) =>
                          setState(() => this.password = password),
                      onUsernameChanged: (username) =>
                          setState(() => this.username = username),
                      onDateOfBirthChanged: (dateOfBirth) =>
                          setState(() => this.dateOfBirth = dateOfBirth),
                      onRegisterPressed: registerUser,
                    ),
                  );
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    final fsp = Provider.of<FirestoreProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      String result = await AuthMethods(fsp).loginWithEmailAndPassword(
        email,
        password,
      );
      if (result == "success") {
        if (kDebugMode) {
          print("Login successful");
          print("User: ${fsp?.fireauth.currentUser!.email}");
        }
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result, textAlign: TextAlign.center),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  void registerUser() async {
    final fsp = Provider.of<FirestoreProvider>(context, listen: false);

    if (kDebugMode) {
      print("Registering user...");
      print("Date of Birth: $dateOfBirth");
    }

    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      String result = await AuthMethods(fsp).registerWithEmailAndPassword(
        email,
        password,
        username,
        dateOfBirth,
      );

      if (result == 'success') {
        if (kDebugMode) {
          print("Registration successful");
          print("User: ${fsp.fireauth.currentUser!.email}");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result, textAlign: TextAlign.center),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
        //Navigator.of(context).pop();
      }
    }
  }
}
