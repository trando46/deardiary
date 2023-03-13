import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class RegisterUserWidget extends StatefulWidget {
  RegisterUserWidget(
      {super.key,
      this.email = '',
      this.password = '',
      this.username = '',
      this.dateOfBirth = '',
      this.userID = '',
      required this.onEmailChanged,
      required this.onPasswordChanged,
      required this.onUsernameChanged,
      required this.onDateOfBirthChanged,
      required this.onRegisterPressed});

  final String email;
  final String password;
  final String username;
  final String dateOfBirth;
  final String userID;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onUsernameChanged;
  final ValueChanged<String> onDateOfBirthChanged;
  final VoidCallback onRegisterPressed;

  @override
  State<RegisterUserWidget> createState() => _RegisterUserWidgetState();
}

class _RegisterUserWidgetState extends State<RegisterUserWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  late String email = widget.email;
  late String password = widget.password;
  late String username = widget.username;
  late String dateOfBirth = widget.dateOfBirth;

  late ValueChanged<String> onEmailChanged = widget.onEmailChanged;
  late ValueChanged<String> onPasswordChanged = widget.onPasswordChanged;
  late ValueChanged<String> onUsernameChanged = widget.onUsernameChanged;
  late ValueChanged<String> onDateOfBirthChanged = widget.onDateOfBirthChanged;
  late VoidCallback onRegisterPressed = widget.onRegisterPressed;

  late DateTime dobBig;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: Key('Register Dialog'),
      title: const Text("Register"),
      actionsAlignment: MainAxisAlignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUsernameField(),
          const SizedBox(height: 5.0),
          _buildEmailField(),
          const SizedBox(height: 5.0),
          _buildPasswordField(),
          const SizedBox(height: 5.0),
          _buildDateOfBirthField(),
          const SizedBox(height: 5.0),
        ],
      ),
      actions: [
        ElevatedButton(
          key: Key('Register cancel button'),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: onRegisterPressed,
          child: const Text("Register"),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      key: Key("Register email"),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onChanged: (value) {
        email = value;
        onEmailChanged(value);
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      key: Key('Register password'),
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) =>
          value != null && value.isEmpty ? 'Please enter your password' : null,
      onChanged: (value) {
        password = value;
        onPasswordChanged(value);
      },
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      key: Key("Register username"),
      controller: _usernameController,
      decoration: const InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
      validator: (value) =>
          value != null && value.isEmpty ? 'Please enter your username' : null,
      onChanged: (value) {
        username = value;
        onUsernameChanged(value);
      },
    );
  }

  Widget _buildDateOfBirthField() {
    return TextFormField(
      key: Key("Register birth"),
      controller: _dateOfBirthController,
      decoration: const InputDecoration(
        labelText: 'Date of Birth',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value != null && value.isEmpty
          ? 'Please enter your date of birth'
          : null,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? selectedDate = await datePicker(context);
        if (selectedDate != null) {
          dateOfBirth = DateFormat.yMMMMd('en-US').format(selectedDate);
          _dateOfBirthController.text = dateOfBirth;
          onDateOfBirthChanged(dateOfBirth);
        }
        // ignore: use_build_context_synchronously
      },
      readOnly: true,
      onEditingComplete: () => FocusScope.of(context).unfocus(),
    );
  }

  Future<DateTime?> datePicker(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ); //.then((value) => onDateOfBirthChanged(value!));
  }
}
