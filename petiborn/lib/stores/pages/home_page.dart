import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petiborn/service/firebase_service.dart';
import 'package:petiborn/stores/pages/appointment_page.dart';
import 'package:petiborn/stores/pages/create_pet_profile_page.dart';
import 'package:petiborn/stores/pages/inf_page.dart';
import 'package:petiborn/stores/pages/pet_care.dart';
import 'package:petiborn/stores/pages/pet_profile_list.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _firebaseService = FirebaseService();
  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      print("User ID: ${_user!.uid}");
      var userData = await _firebaseService.getUserDetails(_user!.uid);
      if (userData != null) {
        setState(() {
          _userData = userData;
          print("User Data: $_userData");
        });
      } else {
        print("User data is null");
      }
    } else {
      print("User is null");
    }
  }

  List<Pet> pets = [
    Pet(name: "Fido", imageUrl: "assets/kopek.jpg", age: 3, breed: "Köpek"),
    Pet(name: "Whiskers", imageUrl: "assets/kedi.jpg", age: 2, breed: "Kedi"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 250, 252),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 107, 120),
        title: Text(
          'Ana Sayfa',
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Pet Care'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PetCarePage()),
                );
              },
            ),
            ListTile(
              title: Text('Information'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoPage()),
                );
              },
            ),
            ListTile(
              title: Text('Evcil Hayvan Profili Oluştur'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreatePetProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_userData != null) ...[
              Text(
                'Email: ${_userData!['email']}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Username: ${_userData!['username']}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
            ] else ...[
              CircularProgressIndicator(),
              
            ],
            Image.asset(
              'assets/PetIBorn.jpg',
              height: 200, // İstenen yüksekliğe ayarlayabilirsiniz
              fit: BoxFit.contain, // İstenen uyum şekline ayarlayabilirsiniz
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var pet in pets)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetProfilePage(pet: pet),
                              ),
                            );
                          },
                          child: Image.asset(
                            pet.imageUrl,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        pet.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentPage()),
                      );
                    },
                    child: Text('Randevu'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PetCarePage()),
                      );
                    },
                    child: Text('Evcil Hayvan Bakımı'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePetProfilePage()),
                      );
                    },
                    child: Text('Evcil Hayvan Profili Oluştur'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoPage()),
                      );
                    },
                    child: Text('Evcil Hayvan Bilgileri'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PetProfileListPage()),
                      );
                    },
                    child: Text('Evcil Hayvan Profil Listesi'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Pet {
  final String name;
  final String imageUrl;
  final int age;
  final String breed;

  Pet({
    required this.name,
    required this.imageUrl,
    required this.age,
    required this.breed,
  });
}

class PetProfilePage extends StatelessWidget {
  final Pet pet;

  PetProfilePage({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evcil Hayvan Profili: ${pet.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Evcil Hayvan Adı: ${pet.name}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Yaşı: ${pet.age}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Cinsi: ${pet.breed}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Image.asset(
              pet.imageUrl,
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
