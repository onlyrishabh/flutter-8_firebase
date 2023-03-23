import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter8/auth/singup.dart';
import 'package:flutter8/ui/post/post_loginscreen.dart';
import 'package:flutter8/utils/utils.dart';
import 'package:flutter8/widgets/roound_button%20.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _auth =FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login(){
    _auth.signInWithEmailAndPassword(email: emailcontroller.text.toString(),
     password: passwordcontroller.text.toString()).then((value){

      utils().toastmassage(value.user!.email.toString());

      Navigator.push(
      context,
      MaterialPageRoute(
     builder: (context) => const PostLoginScreen(),
      ),
    );

     } ).onError((error, stackTrace) {
      debugPrint(error.toString());

      utils().toastmassage(error.toString());
     });
      
     
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope (onWillPop: ()async{
      SystemNavigator.pop();

      return true;

    },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('login')),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                          hintText: 'email',
                          // helperText: 'rks.ccsc@gmail.com',
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          // helperText: 'enter password',
                          prefixIcon: Icon(Icons.lock_open),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                RoundButton(
                  title: 'Log in',
                  ontap: () {
                    if (_formkey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don't have a acount?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SingUp(),
                            ),
                          );
                        },
                        child: Text("sing up"))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
