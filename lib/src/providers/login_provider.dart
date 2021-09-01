import '../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
final RegExp regExpPassword = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  //Constructor
  LoginProvider() {
    _loginType = LoginType.SignUp;
    _username = new ValidationItem();
    _email = new ValidationItem();
    _password = new ValidationItem();
  }

  //Login type - Either Login or Sign up
  LoginType _loginType;
  get loginType => _loginType;
  toggleLoginType() {
    _hasAuthError = false;
    _buttonPressed = false;
    if (_loginType == LoginType.Login) {
      _loginType = LoginType.SignUp;
    } else {
      _loginType = LoginType.Login;
    }
    notifyListeners();
  }

  bool get isSignUp => _loginType == LoginType.SignUp;

  ValidationItem _username;
  ValidationItem _email;
  ValidationItem _password;
  //SignUpData methods
  bool hasError(DataField dataField) {
    if (_loginType == LoginType.Login) return false;
    switch (dataField) {
      case DataField.Email:
        return _email.error;
        break;
      case DataField.Password:
        return _password.error;
        break;
      case DataField.Username:
        return _username.error;
        break;
      default:
        return false;
    }
  }

  void changeData(DataField dataField, String data) {
    _hasAuthError = false;
    switch (dataField) {
      case DataField.Email:
        _email.data = data.trim();
        if (regExpEmail.hasMatch(data.trim())) {
          _email.error = false;
        } else {
          _email.error = true;
        }
        break;
      case DataField.Password:
        _password.data = data.trim();
        if (regExpPassword.hasMatch(data.trim())) {
          _password.error = false;
        } else {
          _password.error = true;
        }
        break;
      case DataField.Username:
        _username.data = data.trim();
        if (data.trim().length > 3) {
          _username.error = false;
        } else {
          _username.error = true;
        }
        break;
    }
    notifyListeners();
  }

  String getErrorMessage(DataField dataField) {
    switch (dataField) {
      case DataField.Email:
        if (_email.error) {
          return "Enter a valid email address";
        }
        break;
      case DataField.Password:
        if (_password.error) {
          if (_password.data.length >= 8) {
            return "Password should contain a digit and a letter";
          } else {
            return "Password should be at least 8 characters long";
          }
        }
        break;
      case DataField.Username:
        if (_username.error) {
          return "Username should be at least 3 characters";
        }
        break;
      default:
        return "Unknown error";
    }
    return "Unknown error";
  }

  int _getErrorNumber() {
    int answer = 0;
    if (_username.error) answer++;
    if (_password.error) answer++;
    if (_email.error) answer++;
    return answer;
  }

  //Login button pressed
  bool _buttonPressed = false;
  set buttonPressed(bool value) {
    _buttonPressed = value;
    notifyListeners();
  }

  bool get buttonPressed => _buttonPressed;
  //Data for animation
  double _overallPosition = 180;
  double get overallPosition =>
      _keyboardOpened ? _overallPosition - 150 : _overallPosition;
  double get loginFieldPosition => overallPosition + 80;
  double get signUpFieldPosition => overallPosition + 50;

  bool _keyboardOpened = false;
  void changeVisibility(bool value) {
    _keyboardOpened = value;
    notifyListeners();
  }

  bool get keyboardOpened => _keyboardOpened;

  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //Authentication - Register/Login
  bool _hasAuthError = false;
  String _authErrorString;
  get hasAuthError => _hasAuthError;
  get authErrorString => _authErrorString;

  void _authError({String error}) {
    _hasAuthError = true;
    print("In _authError: " + error);
    switch (error) {
      case "email-already-in-use":
        _authErrorString = "Entered Email is already in use";
        break;
      case "invalid-email":
        _authErrorString = "Entered Email is not valid";
        break;
      case "operation-not-allowed":
        _authErrorString = "Invalid operation";
        break;
      case "weak-password":
        _authErrorString = "Entered password is too weak";
        break;
      case "user-not-found":
        _authErrorString = "Wrong email or password";
        break;
      case "empty-fields":
        _authErrorString = "Please enter all the required information";
        break;
      case "wrong-password":
        _authErrorString = "Entered password is wrong";
        break;
      default:
        _authErrorString = error;
        break;
    }
    notifyListeners();
  }

  Future<bool> _signUpEmail() async {
    try {
      isLoading = true;
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: _email.data, password: _password.data);
      if (authResult != null) {
        var user = AppUser(
            email: authResult.user.email,
            userId: authResult.user.uid,
            name: _username.data,
            role: Roles.User);
        await _firestoreService.addUser(user);
        return true;
      }
    } on FirebaseAuthException catch (error) {
      _authError(error: error.code);
    } on Exception catch (error) {
      print("Something went wrong: " + error.toString());
    }
    return false;
  }

  Future<bool> _loginEmail() async {
    try {
      if (_email.data == null ||
          _email.data == "" ||
          _password.data == null ||
          _password.data == "") {
        _authError(error: "empty-fields");
      } else {
        isLoading = true;
        await _auth.signInWithEmailAndPassword(
            email: _email.data, password: _password.data);
        return true;
      }
    } on FirebaseAuthException catch (error) {
      _authError(error: error.code);
    }
    return false;
  }

  bool loginClicked = false;

  Future<bool> signUp() async {
    buttonPressed = true;
    _hasAuthError = false;
    loginClicked = true;
    bool answer = false;
    if (_loginType == LoginType.SignUp) {
      if (_getErrorNumber() == 0) {
        answer = await _signUpEmail();
      } else {
        print("There are register errors");
      }
    } else if (_loginType == LoginType.Login) {
      answer = await _loginEmail();
    }
    isLoading = false;
    loginClicked = false;
    return answer;
  }
}

enum LoginType { Login, SignUp }
enum DataField { Email, Password, Username }

class ValidationItem {
  String data = "";
  bool error = true;
}
