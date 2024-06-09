import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetProfileListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 107, 120),
        title: Text('Pet Profilleri'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('pet_profiles').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final petProfiles = snapshot.data!.docs;

          return ListView.builder(
            itemCount: petProfiles.length,
            itemBuilder: (context, index) {
              final petProfile = petProfiles[index];

              return ListTile(
                title: Text(petProfile['pet_name']),
                subtitle: Text(
                    'Cins: ${petProfile['breed']}, Yaş: ${petProfile['age']}'),
                leading: petProfile['image_path'] != null
                    ? Image.file(
                        File(petProfile['image_path']),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.pets),
              );
            },
          );
        },
      ),
    );
  }
}
