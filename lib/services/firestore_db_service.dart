import 'package:chatflutter/model/user.dart';
import 'package:chatflutter/services/database_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDbService implements DBBase {
  final Firestore _firestoreDb = Firestore.instance;


  @override
  Future<bool> saveUser(User user) async {

    //gelen dataya map'e çevir gönder

    await _firestoreDb
        .collection("Users")
        .document(user.userID)
        .setData(user.toMap());
    
//    DocumentSnapshot _readingUser =
//    await Firestore.instance.document("Users/${user.userID}").get();

//   Map _readingUserInformation = _readingUser.data;
//   User _readingModel =  User.fromMap(_readingUserInformation);
//
//   print('okunan user model : ' + _readingModel.toString());
    
    return true;
  }

  @override
  Future<User> readUser(String userID) async{
   // DocumentSnapshot _readingUser = await _firestoreDb.document('$userID').get();
    DocumentSnapshot _readingUser = await _firestoreDb.collection('Users').document(userID).get();
   Map<String,dynamic> _readingUserMap = _readingUser.data;

   User _readingUserModel = User.fromMap(_readingUserMap);
   print('Okunan user nesnesi : ' + _readingUserModel.toString() );
   return _readingUserModel;


  }



}
