import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = '+47 Norway';
  String show = "";

  @override
  void initState() {
    super.initState();
    token_read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              String aStr = dropdownValue.replaceAll(new RegExp(r'[^0-9]'), '');
              print(aStr);
            });
          },
          items: <String>[
            '+47 Norway',
            '+41 Switzerland',
            '+49 Germany',
            '+45 Denmark',
            '+1 United States',
            '+81 Japan'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Text(show),
        SizedBox(
          height: 100,
        ),
        TextButton(
            onPressed: () {
              token_save("sameersingh");
            },
            child: Text("Token Store")),
        SizedBox(
          height: 100,
        ),
        TextButton(
            onPressed: () {
              token_delete();
            },
            child: Text("Token Delete")),
        SizedBox(
          height: 100,
        ),
        TextButton(
            onPressed: () {
              token_read();
            },
            child: Text("Token Show"))
      ],
    );
  }

  token_read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final read_value = prefs.getString(key) ;
    show = read_value.toString();
    setState(() {});
    print('read: $read_value');
    return read_value;
  }

  token_save(@required String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
    print('saved $value');
    setState(() {});
  }

  token_delete() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    prefs.remove(key);
  }
}
