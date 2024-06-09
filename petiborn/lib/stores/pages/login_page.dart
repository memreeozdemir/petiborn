import 'package:flutter/material.dart';
import 'package:petiborn/service/auth.dart'; // Auth sınıfı yerine AuthService sınıfını kullanıyoruz
import 'package:petiborn/stores/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();

  bool isLogin = true;
  String? errorMessage;

  Future<void> createUser() async {
    try {
      // AuthService sınıfı üzerinden signUp metodu çağrılacak
      final result = await AuthService().signUp(
        emailController.text,
        usernameController.text,
        fullnameController.text,
        passwordController.text,
      );
      if (result == "success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        setState(() {
          errorMessage = result;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> login() async {
    try {
      // AuthService sınıfı üzerinden signIn metodu çağrılacak
      final result = await AuthService().signIn(
        emailController.text,
        passwordController.text,
      );
      if (result == "success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        setState(() {
          errorMessage = result;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 250, 252),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 107, 120),
        title: Text(
          isLogin ? "Giriş Yap" : "Kayıt Ol",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50.0),
            Image.asset(
              'assets/PetIBorn.jpg',
              height: 200, // İstenen yüksekliğe ayarlayabilirsiniz
              fit: BoxFit.contain, // İstenen uyum şekline ayarlayabilirsiniz
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Şifre',
              ),
              obscureText: true,
            ),
            if (!isLogin) ...[
              SizedBox(height: 16.0),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: fullnameController,
                decoration: InputDecoration(
                  labelText: 'Tam Adı',
                ),
              ),
            ],
            SizedBox(height: 16.0),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (isLogin) {
                  login();
                } else {
                  createUser();
                }
              },
              child: Text(isLogin ? "Giriş Yap" : "Kayıt Ol"),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin
                    ? "Henüz hesabınız yok mu? Kayıt olun!"
                    : "Zaten hesabınız var mı? Giriş yapın!",
                style: TextStyle(color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
