import 'package:chatflutter/repository/user_repository.dart';
import 'package:chatflutter/services/fake_auth_service.dart';
import 'package:chatflutter/services/firebase_auth_service.dart';
import 'package:chatflutter/services/firestore_db_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthService());
  locator.registerLazySingleton(() => FirestoreDbService());
  locator.registerLazySingleton(() => UserRepository());
}
