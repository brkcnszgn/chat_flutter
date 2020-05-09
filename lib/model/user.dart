import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String userID;
  String email;
  String userName;
  String profileUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int level;

  User({@required this.userID, @required this.email});

  //Nesneyi mape çevirir
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName': userName ?? email.substring(0, email.indexOf('@')) + randomNumberCreate(), //oluşturalan user'in çakışaması için random sayı atandı '',//
      'profileUrl': profileUrl ??
          'https://images.pexels.com/photos/1040157/pexels-photo-1040157.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'level': level ?? 0
    };
  }

  //Bir map alır geriye nesneyi verir
  User.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profileUrl = map['profileUrl'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        level = map['level'];

  @override
  String toString() {
    return 'User{userID: $userID,'
        ' email: $email,'
        ' userName: $userName,'
        ' profileUrl: $profileUrl,'
        ' createdAt: $createdAt,'
        ' updatedAt: $updatedAt,'
        ' level: $level}';
  }

   String randomNumberCreate() {
    int randomNumber = Random().nextInt(99999999);
    return randomNumber.toString();
  }
}
