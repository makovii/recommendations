import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rec_flutter/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';


DateTime _dateTimeFromJson(Object time) {
  if (time is DateTime) {
    return time;
  }
  if (time is String) {
    return DateTime.parse(time);
  }
  if (time is Timestamp) {
    return time.toDate();
  }
  throw Exception("Expected DateTime or Timestamp when parsing User");
}

DateTime _dateTimeOptionalFromJson(Object? time) {
  if (time == null) {
    return DateTime.now();
  }
  return _dateTimeFromJson(time);
}


@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,

    String? name,

    required String email,

    @JsonKey(fromJson: _dateTimeFromJson)
    required DateTime createdTime,

    bool? isNewUser,

    @JsonKey(fromJson: _dateTimeOptionalFromJson)
    DateTime? dateOfBirth,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@Riverpod(keepAlive: true)
class User extends _$User {

  @override
  Future<UserModel> build() async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User is not logged in");
    }

    DocumentReference<UserModel> docRef = usersFirestore.doc(FirebaseAuth.instance.currentUser!.uid);
    UserModel user;
    try {
      user = (await docRef.get(const GetOptions(source: Source.cache))).data()!;
    } catch (e) {
      print("User is not in cache");
      user = (await docRef.get(const GetOptions(source: Source.server))).data()!;
    }
    return user;
  }
}

