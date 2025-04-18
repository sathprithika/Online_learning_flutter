import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/user_model.dart';
import 'screens/home_screen.dart';

import 'screens/enroll_screen.dart';
import 'screens/login_screen.dart';
import 'screens/course_list_screen.dart';
import 'screens/courses_screen.dart';

import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:firebase_core/firebase_core.dart'; // for Firebase & FirebaseOptions

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase depending on the platform (Web/Other)
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyDaJY5Rbb0ljxIrrxSZYPQWQnnGIXvRhVQ",
          authDomain: "learning-app-flutter-7e146.firebaseapp.com",
          projectId: "learning-app-flutter-7e146",
          storageBucket: "learning-app-flutter-7e146.appspot.com",
          messagingSenderId: "521013481213",
          appId: "1:521013481213:web:126857c318754827523894",
          measurementId: "G-YHVVSVDQ29",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    print("Firebase Initialized successfully!");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ✅ Provide default values for required fields in UserModel
  final UserModel userModel = UserModel(
    uid: '',
    userName: '',
    email: '',
    enrolledCourses: [],
  );

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: userModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Learning Companion',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/enroll': (context) => EnrollScreen(),
          '/courselist': (context) => CourseListScreen(),
          '/courses': (context) => CoursesScreen(),
          
        },
      ),
    );
  }
}
