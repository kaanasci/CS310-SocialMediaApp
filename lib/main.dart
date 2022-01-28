import 'package:cs310_week5_app/routes/editprofile.dart';
import 'package:cs310_week5_app/routes/profile.dart';
import 'package:cs310_week5_app/routes/search.dart';
import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/routes/login.dart';
import 'package:cs310_week5_app/routes/home.dart';
import 'package:cs310_week5_app/routes/signup.dart';
import 'package:cs310_week5_app/routes/walkthrough.dart';
import 'package:cs310_week5_app/routes/bildirim.dart';
import 'package:cs310_week5_app/routes/nots_model.dart';
import 'package:cs310_week5_app/routes/nots.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cs310_week5_app/dummy/auth.dart';
import 'package:cs310_week5_app/dummy/no_firebase.dart';
import 'package:cs310_week5_app/dummy/Authenticate.dart';
import 'package:cs310_week5_app/routes/addpost.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print('Cannot connect to firebase: '+snapshot.error);
            return MaterialApp(
              home: NoFirebaseView(),
            );
          }
          if(snapshot.connectionState == ConnectionState.done) {
            print('Firebase connected');
            /*
            return StreamProvider<User>.value(
              value: AuthService().user,
              child: MaterialApp(
                home: Authenticate(),
              ),
            );*/
            return AppBase();
          }
          return MaterialApp(
            home: WaitingFirebase(),
          );
        }
    );
  }
}
class AppBase extends StatelessWidget {
  const AppBase({
    Key key,
  }) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
    routes: {
    '/': (context) => Welcome(),
    '/login': (context) => Login(),
    '/signup': (context) => SignUp(),
    '/walkthrough': (context) => TestScreen(),
    '/home': (context) => HomePage(analytics: analytics, observer: observer),
    '/profile': (context) => ProfilePage(),
    '/search': (context) => Search(),
    '/editprofile' :(context) => EditProfilePage(),
    '/bildirim' :(context) => bildirim(),
      '/addpost' :(context) => AddPost(),
    },
    );
  }
}  //home: Welcome(),
  //initialRoute: '/walkthrough',
 // initialRoute: '/home',



