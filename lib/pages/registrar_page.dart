import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Carro {
  final String nome;
  final String modelo;
  final String tipoLavagem;
  final double preco;
  final String entrada;
  final String data;

  Carro({
    required this.nome,
    required this.modelo,
    required this.tipoLavagem,
    required this.preco,
    required this.entrada,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'modelo': modelo,
      'tipoLavagem': tipoLavagem,
      'preco': preco,
      'entrada': entrada,
      'data': data,
    };
  }

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(nome: json['nome'], modelo: json['modelo'], tipoLavagem: json['tipoLavagem'], preco: json['preco'], entrada: json['entrada'], data: json['data']);
  }
}

Future<void> salvarCarros(List<Carro> carros) async {
  final prefs = await SharedPreferences.getInstance();
  final carrosJson = carros.map((carro) => jsonEncode(carro.toJson())).toList();
  await prefs.setStringList('carros', carrosJson);
}

Future<List<Carro>> carregarCarros() async {
  final prefs = await SharedPreferences.getInstance();
  final carrosJson = prefs.getStringList('carros');
  if (carrosJson == null) {
    return [];
  }
  return carrosJson.map((carroJson) => Carro.fromJson(jsonDecode(carroJson))).toList();
}

class CarroData extends ChangeNotifier {
  List<Carro> registros = [];

  CarroData(List<Carro> carros) {
    registros = carros;
  }

  void adicionarCarro(Carro carro) {
    registros.add(carro);
    salvarCarros(registros);
    notifyListeners();
  }

  void removerCarro(int index) {
    registros.removeAt(index);
    salvarCarros(registros);
    notifyListeners();
  }
}

class RegistrarPage extends StatelessWidget {
  const RegistrarPage({super.key, Key? chave});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController modeloController = TextEditingController();
    final TextEditingController tipoLavagemController = TextEditingController();
    final TextEditingController precoController = TextEditingController();
    final TextEditingController entradaController = TextEditingController();
    final TextEditingController dataController = TextEditingController();

    var carroData = Provider.of<CarroData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: const Text('Registrar Carro', style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic, color: Colors.greenAccent)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.png'), // Substitua 'assets/background_image.png' pelo caminho da sua imagem.
            fit: BoxFit.cover, // Ajuste a forma como a imagem é exibida (pode ser 'cover', 'contain', etc.).
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(70.0),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome', labelStyle: TextStyle(color: Colors.greenAccent), border: OutlineInputBorder(), filled: true, fillColor: Colors.black87),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: modeloController,
                decoration: const InputDecoration(labelText: 'Automóvel', labelStyle: TextStyle(color: Colors.greenAccent), border: OutlineInputBorder(), filled: true, fillColor: Colors.black87),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: tipoLavagemController,
                decoration: const InputDecoration(labelText: 'Tipo de Lavagem', labelStyle: TextStyle(color: Colors.greenAccent), border: OutlineInputBorder(), filled: true, fillColor: Colors.black87),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: precoController,
                decoration: const InputDecoration(labelText: 'Preço', labelStyle: TextStyle(color: Colors.greenAccent), border: OutlineInputBorder(), filled: true, fillColor: Colors.black87),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: entradaController,
                decoration: const InputDecoration(labelText: 'Horário de Entrada', labelStyle: TextStyle(color: Colors.greenAccent), border: OutlineInputBorder(), filled: true, fillColor: Colors.black87),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: dataController,
                decoration: const InputDecoration(labelText: 'Data', labelStyle: TextStyle(color: Colors.greenAccent), border: OutlineInputBorder(), filled: true, fillColor: Colors.black87),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String nome = nomeController.text;
                  String modelo = modeloController.text;
                  String tipoLavagem = tipoLavagemController.text;
                  String precoStr = precoController.text;
                  String entrada = entradaController.text;
                  String data = dataController.text;
                  if (nome.isEmpty || modelo.isEmpty || tipoLavagem.isEmpty || precoStr.isEmpty || entrada.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content: const Text('Preencha todos os campos obrigatórios.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    double preco = double.parse(precoStr);
                    Carro carro = Carro(
                      nome: nome,
                      modelo: modelo,
                      tipoLavagem: tipoLavagem,
                      preco: preco,
                      entrada: entrada,
                      data: data,
                    );

                    carroData.adicionarCarro(carro);

                    nomeController.clear();
                    modeloController.clear();
                    tipoLavagemController.clear();
                    precoController.clear();
                    entradaController.clear();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(
                  'Salvar',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
