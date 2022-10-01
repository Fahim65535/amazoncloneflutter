import 'package:amazone_clone_app/layout/screen_layout.dart';
import 'package:amazone_clone_app/provider/user_details_provider.dart';
import 'package:provider/provider.dart';
import 'screens/barrel_screens.dart';
import 'config/barrel_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserDetailsProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amazon Clone',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (snapshot.hasData) {
                // FirebaseAuth.instance.signOut();
                return const ScreenLayout();
              } else {
                return const SignInScreen();
              }
            },
          )),
    );
  }
}
