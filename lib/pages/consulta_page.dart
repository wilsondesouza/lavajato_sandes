import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'registrar_page.dart';

class ConsultaPage extends StatelessWidget {
  const ConsultaPage({super.key, Key? chave});

  @override
  Widget build(BuildContext context) {
    var carroData = Provider.of<CarroData>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: const Text('Consulta de Carros', style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic, color: Colors.greenAccent)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: carroData.registros.length,
          itemBuilder: (context, index) {
            Carro carro = carroData.registros[index];
            return Container(
              decoration: const BoxDecoration(color: Colors.black87),
              child: ListTile(
                title: Text(
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    'Nome: ${carro.nome}'),
                textColor: Colors.white,
                subtitle: Text(style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14), 'Automóvel: ${carro.modelo}\nTipo de Lavagem: ${carro.tipoLavagem}\nPreço: ${carro.preco}\nEntrada: ${carro.entrada}\nData: ${carro.data}'),
                trailing: IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    carroData.removerCarro(index);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
