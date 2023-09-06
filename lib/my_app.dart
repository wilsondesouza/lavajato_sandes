import 'package:flutter/material.dart';

import 'pages/consulta_page.dart';
import 'pages/home_page.dart';
import 'pages/registrar_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key? chave});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/consultar': (context) => const ConsultaPage(),
        '/registrar': (context) => const RegistrarPage(),
      },
    );
  }
}
