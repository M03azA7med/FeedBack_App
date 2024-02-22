import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback/loginpage.dart';
import 'package:feedback/viewFeedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _AppState();
}

class _AppState extends State<feedback> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('feedback customer'),
            backgroundColor: Colors.deepOrange,
            actions: [
              Row(
                children: [
                  Text('SIGN OUT'),
                  IconButton(onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginscreen(),));
                  },
                    icon: Icon(Icons.exit_to_app),
                  ),
                ],
              ),

            ],

          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Center(
               child: MaterialButton(
                 onPressed: () {
                   showDialog(
                       context: context,
                       builder: (context) => const FeedbackDialog());
                 },
                 child: Text('Open Form',style: TextStyle(color: Colors.white),),
                 color: Colors.deepOrange,
               ),
             ),
           ],
          ),
        ));
  }
}

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);


  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _Branchcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  CollectionReference feedback = FirebaseFirestore.instance.collection('feedback');
  addcategoriesn(context) async {
    // Call the user's CollectionReference to add a new user
    await feedback.add({"Feedback":_controller.text ,"branch":_Branchcontroller.text})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                 TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Enter your feedback here',
                    filled: true,
                  ),
                  maxLines: 5,
                  maxLength: 4096,
                  textInputAction: TextInputAction.done,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                 TextFormField(
                  controller: _Branchcontroller,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Enter branch Name',
                    filled: true,
                  ),
                  maxLines: 5,
                  maxLength: 4096,
                  textInputAction: TextInputAction.done,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),

              // actions: [

                TextButton(
                  child: const Text('Send',style: TextStyle(color: Colors.deepOrange),),
                  onPressed: () async {
                    addcategoriesn(context);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: 'Your Feddback is send ',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                )
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
