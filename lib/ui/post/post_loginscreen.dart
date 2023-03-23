import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter8/auth/login_screen.dart';
import 'package:flutter8/ui/post/add_post.dart';
import 'package:flutter8/utils/utils.dart';

class PostLoginScreen extends StatefulWidget {
  const PostLoginScreen({super.key});

  @override
  State<PostLoginScreen> createState() => _PostLoginScreenState();
}

class _PostLoginScreenState extends State<PostLoginScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("post"),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
              },).onError((error, stackTrace){
                utils().toastmassage(error.toString(),);
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddPostScreen(),
        ),
      );

      },
      child: Icon(Icons.add ),),
    );
  }
}
