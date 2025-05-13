import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _Email = "";
  var _Password = "";
  var _isLogin = true;
  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _Email, password: _Password);
        print(userCredentials);
      } else {
        final userCrendiantials = await _firebase
            .createUserWithEmailAndPassword(email: _Email, password: _Password);
        print(userCrendiantials);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "Email-Already_in-Use") {}

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication failed.")));
    }

    print(_Email);
    print(_Password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
                width: 200,
                child: Image.network(
                    "https://t3.ftcdn.net/jpg/00/62/07/58/360_F_62075848_H4lWOX9siQr8thq6pPjrG8rwoFAtBg4I.jpg"),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: "Email"),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains("@")) {
                                  return "Plz Enter Valid Email";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _Email = value!;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return "Pasword must be at least ^ character long";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _Password = value!;
                              },
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _submit();
                                },
                                child: Text(_isLogin ? "Login" : "SignUp")),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(_isLogin
                                    ? "Create An Account"
                                    : "I Already Have aan AAaccount. login"))
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
