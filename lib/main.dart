import 'package:flutter/material.dart';
import 'package:shopping_app/di.dart';
import 'package:shopping_app/screen/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const GlobalBlocProviders(
      child: MaterialApp(
        home: ShoppingApp(),
      ),
    ),
  );
}
