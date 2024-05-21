import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rec_flutter/const.dart';
import 'package:rec_flutter/models/user/user.dart';

CollectionReference<UserModel> usersFirestore = FirebaseFirestore.instance.collection(userFirestore).withConverter(
    fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
    toFirestore: (model, _) => model.toJson()
);
