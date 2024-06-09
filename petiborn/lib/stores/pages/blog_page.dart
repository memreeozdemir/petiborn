import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Başlık 1'),
            subtitle: Text('Yazı 1 açıklaması...'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Başlık 2'),
            subtitle: Text('Yazı 2 açıklaması...'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Blog Uygulaması',
    home: BlogPage(),
  ));
}
