

import 'package:feedback/feedback.dart';
import 'package:feedback/view/onboarding.dart';
import 'package:feedback/viewFeedback.dart';
import 'package:feedback/widget/onbording.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget widget;
    var user=FirebaseAuth.instance.currentUser?.uid;
    if(user=="D1bl0UhvpCVqpWvSFU7VPwajR8w1"){
      widget=viewFeedback();
    }else{
      widget=feedback();
    }
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:onbording(),
    );
  }
}