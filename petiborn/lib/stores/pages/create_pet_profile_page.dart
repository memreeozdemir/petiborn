import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePetProfilePage extends StatefulWidget {
  @override
  _CreatePetProfilePageState createState() => _CreatePetProfilePageState();
}

class _CreatePetProfilePageState extends State<CreatePetProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _petName = '';
  String _breed = '';
  int _age = 0;
  XFile? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Firestore'a veri kaydet
      await FirebaseFirestore.instance.collection('pet_profiles').add({
        'pet_name': _petName,
        'breed': _breed,
        'age': _age,
        'image_path': _image
            ?.path, // Bu basit bir örnek, daha sonra Firebase Storage kullanarak fotoğraf yükleyebiliriz
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted')),
      );

      // Formu temizle
      _formKey.currentState!.reset();
      setState(() {
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 107, 120),
        title: Text('Pet Profili Oluştur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Pet Bilgileri',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _image != null
                  ? Image.file(
                      File(_image!.path),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(height: 0),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Fotoğraf Seç'),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Pet İsmi',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pet ismi boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _petName = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Cins',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Cins boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _breed = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Yaş',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Yaş boş olamaz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value!);
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  'Profil Oluştur',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Pet Profili Oluşturma',
    home: CreatePetProfilePage(),
  ));
}
