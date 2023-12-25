import 'dart:io';

import 'package:eshop/Controllers/AuthenticationController.dart';
import 'package:eshop/SetupLocator.dart';
import 'package:eshop/Views/CartView.dart';
import 'package:eshop/Views/ProductListView.dart';
import 'package:eshop/Views/ProfileView.dart';
import 'package:eshop/Views/RegistrationView.dart';
import 'package:flutter/material.dart';

import 'Views/AuthenticationView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SetupLocator();

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/authentication', // Початковий маршрут
        routes: {
          '/mainApp': (context) => const MyHomePage(title: 'TradeWave Home Page'),
          // Маршрут для домашнього екрану
          '/authentication': (context) => const AuthenticationView(),
          // Маршрут для екрану товарів
          '/registration': (context) => const RegistrationView(),
          // Маршрут для екрану корзини
        },
        title: 'TradeWave',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late Widget _currentWidget;

  @override
  void initState() {
    super.initState();
    _currentWidget = ProductListView(myHomePageState: this);
  }
  
  void DisplayWidget(String buttonText) {
    Widget newWidget;
    
    switch(buttonText) {
      case "Home":
        newWidget = ProductListView(myHomePageState: this);
        break;
      case "Catalog":
        newWidget = ProductListView(myHomePageState: this);
        break;
      case "Find":
        newWidget = ProductListView(myHomePageState: this);
        break;
      case "Cart":
        newWidget = CartView(myHomePageState: this);
        break;
      case "Profile":
        newWidget = ProfileView(myHomePageState: this);
        break;
      default:
        throw Exception("There are no any menu with the same name: $buttonText");
    }
    
    setState(() {
      _currentWidget = newWidget; // Змінюємо вміст на новий виджет
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration:
              const BoxDecoration(color: Color.fromRGBO(21, 27, 31, 1)),
              child: _currentWidget,
            ),
          ),
          Container(
            height: 50, // Статична висота для нижньої панелі
            decoration:
            const BoxDecoration(color: Color.fromRGBO(33, 39, 42, 1)),
            child: Row(
              children: [
                _buildButton("assets/images/homeImage.png", "Home", DisplayWidget),
                _buildButton("assets/images/catalogImage.png", "Catalog", DisplayWidget),
                _buildButton("assets/images/findImage.png", "Find", DisplayWidget),
                _buildButton("assets/images/cartImage.png", "Cart", DisplayWidget),
                _buildButton("assets/images/profileImage.png", "Profile", DisplayWidget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildButton(String imagePath, String text, Function func) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        func(text);
      },
      child: Column(
        children: [
          Expanded(child: Image.asset(imagePath)),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}
