

import 'dart:math';

class Profile{
  String name;
  String locale;
  String userName;
  String profileUrl;
  String email;
  bool email_verified;



  Map<String, dynamic> toMap() {
    return {
      'userID': name,
      'email': locale,
      'userName': userName ?? email.substring(0, email.indexOf('@')) + randomNumberCreate(), //oluşturalan user'in çakışaması için random sayı atandı '',//
      'profileUrl': profileUrl ?? 'https://images.pexels.com/photos/1040157/pexels-photo-1040157.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
      'email': email,
      'email_verified': email_verified ?? false,

    };
  }

  String randomNumberCreate() {
    int randomNumber = Random().nextInt(99999999);
    return randomNumber.toString();
  }
}