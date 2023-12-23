import 'dart:io';
import 'package:eshop/Controllers/RegistrationController.dart';
import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/ViewModels/UserView.dart';
import 'package:eshop/Views/Animations/MyPageRoute.dart';
import 'package:eshop/Views/AuthenticationView.dart';
import 'package:flutter/material.dart';

import '../Controllers/AuthenticationController.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final RegistrationController _registrationController =
      RegistrationController();
  bool _isNameValid = false, _isEmailValid = false, _isPasswordValid = false, _isConfirmValid = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool isButtonEnabled = false;

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
                  child: const Text('Registration',
                      style: TextStyle(color: Colors.grey, fontSize: 30)),
                ),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  onChanged: (value) {
                    NameValidate(value);                    
                    UpdateButtonState();
                  },
                  validator: (value) {
                    return NameValidate(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromRGBO(33, 39, 42, 1),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 40),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  onChanged: (value) {
                    PasswordValidate(value);
                    PasswordConfirmValidate(_passwordConfirmController.text);
                    
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
                TextFormField(
                  controller: _passwordConfirmController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  onChanged: (value) {
                    PasswordConfirmValidate(value);
                    UpdateButtonState();
                  },
                  validator: (value) {
                    return PasswordConfirmValidate(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: "Confirm password",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromRGBO(33, 39, 42, 1),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isButtonEnabled ? _onRegisterButtonPressed : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isButtonEnabled ? const Color.fromRGBO(33, 39, 42, 1) : Colors.black38,
                    
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MyPageRoute(page: const AuthenticationView()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void UpdateButtonState() {
      setState(() {
        isButtonEnabled = _isNameValid && _isEmailValid && _isPasswordValid &&
            _isConfirmValid;
      });
  }

  void _onRegisterButtonPressed() {
    if(!isButtonEnabled) return;
    
    UserView userView = UserView.empty();
    userView.name = _passwordController.text;
    userView.email = _emailController.text;
    userView.password = _passwordController.text;
    userView.passwordConfirm = _passwordConfirmController.text;

    _registrationController.Register(context, userView);
  }
  
  String? NameValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isNameValid = false;
      return 'Please enter your name';
    }
    if (value.length <= 3 || value.length > 30) {
      _isNameValid = false;
      return 'Your name must have minimum 4 and maximum 30 symbols';
    }
    _isNameValid = true;
    return null;
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
  
  String? PasswordConfirmValidate(String? value) {
    if (value == null || value.isEmpty) {
      _isConfirmValid = false;
      return 'Please enter your password again';
    }
    if (value != _passwordController.text) {
      _isConfirmValid = false;
      return 'Your passwords don`t match';
    }
    _isConfirmValid = true;
    return null;
  }
}
