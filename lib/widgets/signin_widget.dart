import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:email_validator/email_validator.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    super.key,
    this.email = '',
    this.password = '',
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onSignInPressed,
  });

  final String email;
  final String password;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onSignInPressed;

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late String email = widget.email;
  late String password = widget.password;
  late ValueChanged<String> onEmailChanged = widget.onEmailChanged;
  late ValueChanged<String> onPasswordChanged = widget.onPasswordChanged;
  late VoidCallback onSignInPressed = widget.onSignInPressed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: Key('Sign In Dialog'),
      title: const Text("Sign In"),
      actionsAlignment: MainAxisAlignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildEmailField(),
          const SizedBox(height: 5.0),
          _buildPasswordField(),
        ],
      ),
      actions: [
        ElevatedButton(
        key: Key("Sign In Dialog Cancel Button"),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          key: Key('Sign In Dialog Sign In Button'),
          onPressed: onSignInPressed,
          child: const Text("Sign In"),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      key: Key('Enter Email'),
      controller: _emailController,
      onChanged: onEmailChanged,
      keyboardType: TextInputType.emailAddress,
      //initialValue: email,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Please enter your email",
      ),
      validator: (email) =>
          EmailValidator.validate(email!) ? null : "Please enter a valid email",
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      key: Key('Enter Password'),
      controller: _passwordController,
      onChanged: onPasswordChanged,
      //initialValue: password,
      obscureText: true,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Please enter your password",
      ),
      validator: (password) {
        password != null && password.isEmpty ? "Please enter a password" : null;
      },
    );
  }
}
