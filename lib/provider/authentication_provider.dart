import 'package:chat_provider/models/chat_user.dart';
import 'package:chat_provider/services/database_service.dart';
import 'package:chat_provider/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    // _auth.signOut();
    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        print('Logged in');
        _databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then(
          (_snapshot) {
            print('_snapshot: $_snapshot');
            print('_snapshot.data(): ${_snapshot.data()}');
            Map<String, dynamic> _userData =
                _snapshot.data()! as Map<String, dynamic>;
            print('_userData: $_userData');
            user = ChatUser.fromJSON(
              {
                'uid': _user.uid,
                'name': _userData['name'],
                'email': _userData['email'],
                'image': _userData['image'],
                'last_active': _userData['last_active'],
              },
            );
            print('user: ${user.toMap()}');
            _navigationService.removeAndNavigateToRoute('/home');
          },
        );
      } else {
        print('Not Authenticated');
        _navigationService.removeAndNavigateToRoute('/login');
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      print(_auth.currentUser);
    } on FirebaseException catch (e) {
      print('Error logging user into Firebase');
    } catch (e) {
      print(e);
    }
  }
}
