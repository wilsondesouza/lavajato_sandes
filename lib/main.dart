import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';
import 'pages/registrar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final carros = await carregarCarros();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CarroData(carros),
      child: const MyApp(),
    ),
  );
}
