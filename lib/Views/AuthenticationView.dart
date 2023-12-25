import 'dart:io';
import 'package:eshop/Models/ViewModels/UserView.dart';
import 'package:eshop/Views/Animations/MyPageRoute.dart';
import 'package:eshop/Views/RegistrationView.dart';
import 'package:flutter/material.dart';

import '../Controllers/AuthenticationController.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  final AuthenticationController _authenticationController =
      AuthenticationController();
  bool _isEmailValid = false, _isPasswordValid = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void OnLoginButtonPressed() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    _authenticationController.Authenticate(context, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 39, 42, 1),
        centerTitle: true,
        title: const Text("TradeWave",
            style: TextStyle(color: Colors.white70, fontSize: 30)),
      ),
      backgroundColor: const Color.fromRGBO(21, 27, 31, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  alignment: Alignment.center,
                  child: const Text('Authentication',
                      style: TextStyle(color: Colors.grey, fontSize: 30)),
                ),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  onChanged: (value) {
                    EmailValidate(value);
                    UpdateButtonState();
                  },
                  validator: (value) {
                    return EmailValidate(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromRGBO(33, 39, 42, 1),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  onChanged: (value) {
                    PasswordValidate(value);
                    UpdateButtonState();
                  },
                  validator: (value) {
                    return PasswordValidate(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromRGBO(33, 39, 42, 1),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isButtonEnabled ? OnLoginButtonPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(33, 39, 42, 1),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pushReplacementNamed(context, '/registration');
                    Navigator.push(
                      context,
                      MyPageRoute(page: const RegistrationView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'I don\'t have an account yet. Register',
                    style: TextStyle(color: Colors.white38, fontSize: 16),
                  ),
                ),
                if (const bool.fromEnvironment('dart.vm.product') != true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            _authenticationController.Authenticate(
                                context, "manager@wave.ua", "12345");
                          },
                          child: const Text("Manager")),
                      TextButton(
                          onPressed: () {
                            _authenticationController.Authenticate(
                                context, "customer@wave.ua", "12345");
                          },
                          child: const Text("Customer"))
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void UpdateButtonState() {
    setState(() {
      isButtonEnabled = _isEmailValid && _isPasswordValid;
    });
  }

  String? EmailValidate(String? value) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (value == null || value.isEmpty) {
      _isEmailValid = false;
      return 'Please enter your email';
    }
    if (value.length <= 3 || value.length > 30) {
      _isEmailValid = false;
      return 'Please enter your name';
    }
    if (!emailRegExp.hasMatch(value)) {
      _isEmailValid = false;
      return 'Your email isn`t correct!';
    }
    _isEmailValid = true;
    return null;
  }

  String? PasswordValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isPasswordValid = false;
      return 'Please enter your password';
    }
    _isPasswordValid = true;
    return null;
  }
}
