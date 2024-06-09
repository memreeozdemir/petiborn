import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  String _selectedDate = 'Tarih Seçilmedi';
  String _selectedTime = 'Saat Seçilmedi';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate.toString();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime.toString();
      });
    }
  }

  Future<void> _saveAppointment() async {
    if (_selectedDate == 'Tarih Seçilmedi' ||
        _selectedTime == 'Saat Seçilmedi') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen geçerli bir tarih ve saat seçin')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('appointments').add({
      'date': _selectedDate,
      'time': _selectedTime,
      'created_at': Timestamp.now(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Randevu başarıyla kaydedildi')),
    );
    setState(() {
      _selectedDate = 'Tarih Seçilmedi';
      _selectedTime = 'Saat Seçilmedi';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 250, 252), // Arka plan rengi
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 107, 120),
        title: Text('Randevu Al'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Kaydedilen Randevular',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('appointments')
                  .orderBy('created_at', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<Widget> appointmentsWidgets = [];
                final appointments = snapshot.data!.docs;
                for (var appointment in appointments) {
                  final date = appointment['date'];
                  final time = appointment['time'];

                  appointmentsWidgets.add(
                    ListTile(
                      title: Text('Tarih: $date - Saat: $time'),
                    ),
                  );
                }

                return ListView(
                  children: appointmentsWidgets,
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Tarih Seç'),
          ),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: Text('Saat Seç'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveAppointment,
            child: Text('Randevuyu Kaydet'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Randevu Al',
    home: AppointmentPage(),
  ));
}
