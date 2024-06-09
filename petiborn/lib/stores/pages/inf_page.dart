import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<String> _formSubmissions = [];

  void _submitForm(String text) {
    setState(() {
      _formSubmissions.add(text);
    });
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 250, 252),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 107, 120),
        title: Text('Evcil Hayvan Bilgileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Evcil Hayvanlar Hakkında Bilgi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Bu sayfada evcil hayvanlar hakkında bilgiler bulabilirsiniz.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: 'Bir şeyler yazın...',
                labelText: 'Form',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (String text) {
                _submitForm(text);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Formlar:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _formSubmissions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_formSubmissions[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Evcil Hayvan Bilgileri',
    home: InfoPage(),
  ));
}
