import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import 'package:amazone_clone_app/screens/barrel_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //textfield controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpwdController = TextEditingController();
  final addressController = TextEditingController();

  //cloud firestore instance
  CloudFirestore cloudFirestore = CloudFirestore();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpwdController.dispose();
    addressController.dispose();
    super.dispose();
  }

// creating auth
  Future<String> signUp(
      {required String name,
      required String address,
      required String email,
      required String pwd,
      required String confirmpwd}) async {
    name.trim();
    address.trim();
    email.trim();
    pwd.trim();
    confirmpwd.trim();
    String output = 'Something went wrong';
    if (name != '' && email != '' && pwd != '' && confirmpwd != '') {
      try {
        if (confirmPwd()) {
          //loading indicator
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
          //creating user with email and pwd
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: pwd,
          );

          //creating user data using cloud firestore
          await cloudFirestore.userData(
              user: UserDetails(
            address: address,
            name: name,
          ));

          //dismiss loading indiactor
          Navigator.pop(context);

          output = 'success';
        }
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = 'Fill up before proceeding.';
    }
    return output;
  }

//method to confirm password
  bool confirmPwd() {
    if (passwordController.text.trim() == confirmpwdController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //amazon logo
                Image.network(
                  amazonLogo,
                  height: screenSize.height * 0.07,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: screenSize.height * 0.80,
                  child: FittedBox(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: screenSize.height * 0.95,
                      width: screenSize.width * 0.95,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //sign in text
                          const Text(
                            'Sign-Up',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 33),
                          ),
                          const SizedBox(height: 30),

                          //name field
                          TextFieldWidget(
                            controller: nameController,
                            obscureText: false,
                            title: 'Name',
                            hintText: 'Enter your name',
                          ),
                          const SizedBox(height: 25),

                          //address field
                          TextFieldWidget(
                            controller: addressController,
                            obscureText: false,
                            title: 'Address',
                            hintText: 'Enter your Address',
                          ),
                          const SizedBox(height: 25),

                          //email field
                          TextFieldWidget(
                            controller: emailController,
                            obscureText: false,
                            title: 'Email',
                            hintText: 'Enter your email',
                          ),
                          const SizedBox(height: 25),

                          //password field
                          TextFieldWidget(
                            controller: passwordController,
                            obscureText: true,
                            title: 'Password',
                            hintText: 'Enter your password',
                          ),
                          const SizedBox(height: 25),

                          //confirm password field
                          TextFieldWidget(
                            controller: confirmpwdController,
                            obscureText: true,
                            title: 'Confirm Password',
                            hintText: 'Confirm your password',
                          ),
                          const SizedBox(height: 35),

                          //sign in button
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: yellowColor,
                                  fixedSize: Size(screenSize.width * 0.7, 40)),
                              onPressed: () async {
                                String output = await signUp(
                                  name: nameController.text,
                                  address: addressController.text,
                                  email: emailController.text,
                                  pwd: passwordController.text,
                                  confirmpwd: confirmpwdController.text,
                                );
                                if (output == 'success') {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (_) {
                                      return const SignInScreen();
                                    },
                                  ));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Alert!'),
                                        content: Text(output),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: yellowColor),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Back',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                //create account button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                        fixedSize: Size(screenSize.width * 0.70, 40)),
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) {
                        return const SignInScreen();
                      },
                    )),
                    child: const Text(
                      'Back',
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
