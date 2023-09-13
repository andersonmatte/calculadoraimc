import 'package:calculadoraimc/pessoa.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
        ),
        body: CalculadoraIMC(),
      ),
    );
  }
}

class CalculadoraIMC extends StatefulWidget {
  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerPeso = TextEditingController();
  final TextEditingController _controllerAltura = TextEditingController();
  double? resultadoIMC;
  String classificacao = "";

  Pessoa? pessoa;

  void calcularIMC() {
    String nome = _controllerNome.text;
    double? peso = double.tryParse(_controllerPeso.text);
    double? alturaEmCentimetros = double.tryParse(_controllerAltura.text);

    if (nome.isNotEmpty && peso != null && alturaEmCentimetros != null) {
      double alturaEmMetros =
          alturaEmCentimetros / 100; // Converter para metros
      double imc = peso / (alturaEmMetros * alturaEmMetros);
      setState(() {
        resultadoIMC = imc;
        classificacao = _classificarIMC(imc);
      });
      pessoa = Pessoa(_controllerNome.text, peso!, alturaEmCentimetros!);
    }
  }

  String _classificarIMC(double imc) {
    if (imc < 16) {
      return "Magreza grave";
    } else if (imc < 17) {
      return "Magreza Moderada";
    } else if (imc < 18.5) {
      return "Magreza Leve";
    } else if (imc < 25) {
      return "Saudável";
    } else if (imc < 30) {
      return "Sobrepeso";
    } else if (imc < 35) {
      return "Obesidade Grau 1";
    } else if (imc < 40) {
      return "Obesidade Grau 2 (severa)";
    } else {
      return "Obesidade Grau 3 (mórbida)";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: _controllerNome,
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Ex: João',
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _controllerPeso,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                hintText: 'Ex: 62',
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _controllerAltura,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                hintText: 'Ex: 183',
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 350,
                margin: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: calcularIMC,
                  child: Text(
                    "Calcular".toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          resultadoIMC != null
              ? Column(
                  children: <Widget>[
                    Text(
                      'Resultado do IMC de ${pessoa?.nome}\nIMC: ${resultadoIMC?.toStringAsFixed(2)}\nClassificação: $classificacao',
                      style: const TextStyle(
                        color: Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
