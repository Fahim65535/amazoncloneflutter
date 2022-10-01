import 'package:amazone_clone_app/screens/barrel_screens.dart';
import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    //loading indicator
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    //dismiss loading indicator
    // Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //amazon logo
                Image.network(
                  amazonLogo,
                  height: screenSize.height * 0.10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: screenSize.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //sign in text
                      const Text(
                        'Sign-In',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 30),
                      ),
                      const SizedBox(height: 40),

                      //email field
                      TextFieldWidget(
                        controller: _emailController,
                        obscureText: false,
                        title: 'Email',
                        hintText: 'Enter your email',
                      ),
                      const SizedBox(height: 25),

                      //password field
                      TextFieldWidget(
                        controller: _passwordController,
                        obscureText: true,
                        title: 'Password',
                        hintText: 'Enter your password',
                      ),
                      const SizedBox(height: 25),

                      //sign in button
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: yellowColor,
                            fixedSize: Size(screenSize.width * 0.7, 40),
                          ),
                          onPressed: signIn,
                          child: const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //new to amazon?
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'New to Amazon?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                //create account button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                        fixedSize: Size(screenSize.width * 0.7, 40)),
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) {
                        return const SignUpPage();
                      },
                    )),
                    child: const Text(
                      'Create an Amazon Account',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
