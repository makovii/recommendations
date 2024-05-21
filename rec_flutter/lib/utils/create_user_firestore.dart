import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rec_flutter/const.dart';
import 'package:rec_flutter/models/user/user.dart';

Future<UserModel> createUserInFirestore(UserCredential userCredential) async {

  try {
    CollectionReference users = FirebaseFirestore.instance.collection(userFirestore);

    DocumentSnapshot docSnapshot = await users.doc(userCredential.user!.uid).get();
    if (docSnapshot.exists) {
      final userData = UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      return userData;
    }

    final userData = {
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'name': userCredential.user!.displayName?? "",
      'isNewUser': true,
      'createdTime': DateTime.now(),
    };

    await users.doc(userCredential.user!.uid).set(userData);
    print('User added to Firestore');
    return UserModel.fromJson(userData);

    
  } catch (error) {
    print('Error adding user to Firestore: $error');
    throw('Error adding user to Firestore: $error');
  }
}
