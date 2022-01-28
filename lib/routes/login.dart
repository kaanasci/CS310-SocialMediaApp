import 'package:cs310_week5_app/dummy/auth.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  String _message = '';
  int attemptCount;
  String mail;
  String pass;
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;


  void setmessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  Future<void> signupUser() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: mail, password: pass);
      print(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if(e.code == 'email-already-in-use') {
        setmessage('This email is already in use');
      }
      else if(e.code == 'weak-password') {
        setmessage('Weak password, add uppercase, lowercase, digit, special character, emoji, etc.');
      }
    }
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: mail,
          password: pass
      );
      print(userCredential.toString());

    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if(e.code == 'user-not-found') {
        signupUser();
      }
      else if (e.code == 'wrong-password') {
        setmessage('Please check your password');
      }
    }
  }

  @override
  void initState() {
    super.initState();

    auth.authStateChanges().listen((User user) {
      if(user == null) {
        print('User is signed out');
      }
      else {
        print('User is signed in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build called');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Image.network('https://cdn.discordapp.com/attachments/775774391912103937/831271171235905556/unknown.png',scale: 1),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary,
                            filled: true,
                            hintText: 'E-mail',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            if(!EmailValidator.validate(value)) {
                              return 'The e-mail address is not valid';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            mail = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0,),


                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary,
                            filled: true,
                            hintText: 'Password',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if(value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            pass = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16,),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: ()  async{
                            if(_formKey.currentState.validate()){
                              _formKey.currentState.save();

                              dynamic result = await _auth.signInWithEmailAndPassword(mail, pass);

                              if(result == null) {
                                print('Registration failed');
                              }
                              else {
                                print('User registered');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Successfuly signed up')));
                                Navigator.pushNamed(context, '/home');
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Login',
                              style: kButtonDarkTextStyle,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    _message,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
