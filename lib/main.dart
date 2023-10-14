import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _temperatureController = TextEditingController();
  String? _selectedUnit = 'Celsius'; // Change _selectedUnit to String?

  double _celsius = 0;
  double _fahrenheit = 0;
  double _kelvin = 0;

  void _convertTemperature() {
    setState(() {
      final double temperature = double.tryParse(_temperatureController.text) ?? 0;

      if (_selectedUnit == 'Celsius') {
        _celsius = temperature;
        _fahrenheit = (temperature * 9 / 5) + 32;
        _kelvin = temperature + 273.15;
      } else if (_selectedUnit == 'Fahrenheit') {
        _fahrenheit = temperature;
        _celsius = (temperature - 32) * 5 / 9;
        _kelvin = (_celsius + 273.15);
      } else {
        _kelvin = temperature;
        _celsius = temperature - 273.15;
        _fahrenheit = (_celsius * 9 / 5) + 32;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Temperature Converter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                DropdownButton<String>( // DropdownButton<String> remains the same
                  value: _selectedUnit,
                  onChanged: (String? newValue) { // Use String? for newValue
                    setState(() {
                      _selectedUnit = newValue;
                    });
                  },
                  items: <String>['Celsius', 'Fahrenheit', 'Kelvin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _temperatureController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Temperature',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _convertTemperature,
                  child: Text('Convert'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Celsius: ${_celsius.toStringAsFixed(2)}°C',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Fahrenheit: ${_fahrenheit.toStringAsFixed(2)}°F',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Kelvin: ${_kelvin.toStringAsFixed(2)}K',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Developed by Nouman Khan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
