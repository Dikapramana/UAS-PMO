import 'package:aplikasi_online/components/cart.dart';
import 'package:aplikasi_online/screens/Login.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
      // ignore: prefer_const_constructors
      options: FirebaseOptions(
          apiKey: "AIzaSyAvF83nwYOQEovtAC_vZYgENyVWApNuCj0",
          appId: "1:434749980404:android:1da4e8cc357833209528a1",
          messagingSenderId: "434749980404",
          projectId: "food-email-7695d"));
  runApp(const MyApp());
}

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => CartModel(),
            // ignore: prefer_const_constructors
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginPage(),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
