import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = "0";
  double _firstNumber = 0;
  double _secondNumber = 0;
  String _operator = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _display = "0";
        _firstNumber = 0;
        _secondNumber = 0;
        _operator = "";
      } else if (value == "+" || value == "-" || value == "x" || value == "÷") {
        _operator = value;
        _firstNumber = double.tryParse(_display) ?? 0;
        _display = "0";
      } else if (value == "=") {
        _secondNumber = double.tryParse(_display) ?? 0;
        switch (_operator) {
          case "+":
            _display = (_firstNumber + _secondNumber).toString();
            break;
          case "-":
            _display = (_firstNumber - _secondNumber).toString();
            break;
          case "x":
            _display = (_firstNumber * _secondNumber).toString();
            break;
          case "÷":
            _display = _secondNumber != 0
                ? (_firstNumber / _secondNumber).toString()
                : "Erro";
            break;
        }
        _operator = "";
      } else {
        if (_display == "0") {
          _display = value;
        } else {
          _display += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
        backgroundColor: const Color.fromARGB(255, 202, 35, 72),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("÷"),
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("x"),
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                  _buildButton("0"),
                  _buildButton("."),
                  _buildButton("="),
                  _buildButton("+"),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _onButtonPressed("C");
            },
            child: const Text("Limpar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 228, 54, 97),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () {
        _onButtonPressed(value);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300], 
        foregroundColor: const Color.fromARGB(255, 196, 27, 131), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
