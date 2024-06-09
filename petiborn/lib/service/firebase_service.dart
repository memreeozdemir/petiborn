import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petiborn/service/post_model.dart';

class FirebaseService {
  final usersCol = FirebaseFirestore.instance.collection("Users");

  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    try {
      final userDoc = await usersCol.doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data();
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user details: $e");
      return null;
    }
  }

  Future<Posts?> getUserPosts(String userId) async {
    try {
      final userDoc = await usersCol.doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          final postsModel = Posts.fromJson(userData);
          return postsModel;
        } else {
          print("User data is null");
          return null;
        }
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user posts: $e");
      return null;
    }
  }
}
