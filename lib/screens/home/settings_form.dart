import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey= GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget> [
          Text(
              'Update your brew settings.',
            style: TextStyle(fontSize: 18.0),

          ),
          SizedBox(height: 20.0),

          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator:  (val) => val == null || val.isEmpty ? 'Please Enter a  name' :null,
            onChanged: (val) {
              setState(() => _currentName = val);
            },

          ),
          SizedBox(height: 20.0),

          // DropdownButtonFormField<String>(value: sugars.first,
           DropdownButtonFormField(
             value: _currentSugars ?? '0',
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text('$sugar sugars'),
              );

            }).toList(),
            onChanged: (value) {
              setState(() => _currentSugars = value);

            },
            decoration: InputDecoration(
              labelText: 'Sugars',
              border: OutlineInputBorder(),
            ),

          ),

          // DropdownButtonFormField(
          //   value: _currentSugars ?? '0',
          //   decoration: InputDecoration(
          //     labelText: 'Sugars',
          //     border: OutlineInputBorder(),
          //   ), items: [],
          // )
          Slider(
            min: 100,
            max: 900,
            divisions: 8,
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[100],
            value: (_currentStrength ?? 100).toDouble(),
            onChanged: (val) {
              setState(() => _currentStrength = val.round());
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            ),
            child: Text(
              'update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            }

          )
        ],
      ),
    );
  }
}
