import 'package:flutter/material.dart';

class PetCarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 250, 252),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 107, 120),
        title: Text('Evcil Hayvan Bakımı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Evcil Hayvan Bakımı',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Evcil hayvanlarınızın sağlıklı ve mutlu olmaları için bazı temel bakım ihtiyaçları vardır. İşte bazı temel bakım ipuçları:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '1. Beslenme: Evcil hayvanınıza uygun bir diyet sağlamak önemlidir. Veterinerinizin önerdiği dengeli bir beslenme planını takip edin.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '2. Egzersiz: Evcil hayvanlarınızın düzenli egzersiz yapmalarını sağlayın. Bu, onların fiziksel ve zihinsel sağlığı için önemlidir.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '3. Temizlik: Evcil hayvanınızın bakımını yaparken hijyenik koşullara dikkat edin. Tüylerini düzenli olarak taramak ve yıkamak önemlidir.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '4. Veteriner Kontrolleri: Evcil hayvanınızın düzenli veteriner kontrollerine gitmesini sağlayın. Bu, erken teşhis ve tedavi için önemlidir.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '5. Sevgi ve İlgi: Evcil hayvanlarınızın sevgi ve ilgiye ihtiyacı vardır. Onlara zaman ayırın, oyun oynayın ve sevginizi gösterin.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Evcil Hayvan Bakımı',
    home: PetCarePage(),
  ));
}
