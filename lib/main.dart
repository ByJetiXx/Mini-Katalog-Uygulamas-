import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MiniCatalogApp());
}

class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mini Katalog",

      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),

      home: const HomePage(),
    );
  }
}
