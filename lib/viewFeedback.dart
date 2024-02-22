import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class viewFeedback extends StatefulWidget {
  const viewFeedback({super.key});

  @override
  State<viewFeedback> createState() => _viewFeedbackState();
}

class _viewFeedbackState extends State<viewFeedback> {
  List<QueryDocumentSnapshot>data=[];
  getData()async{
    QuerySnapshot querySnapshot=
    await FirebaseFirestore.instance.collection("feedback").get();

    data.addAll(querySnapshot.docs);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('View Feedback (Admin)'),
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
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount:1),
        itemCount: data.length,
        itemBuilder: (context, index) =>Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${data[index]['Feedback']}',style: TextStyle(color: Colors.black,fontSize: 20),),
              SizedBox(height: 10,),
                Text('Branch : ${data[index]['branch']}',style: TextStyle(color: Colors.black,fontSize: 20),),


            // DropdownButton(items: , onChanged: (value){
            //   print(value);
            //   print('************************************************************');
            // })
            ],
          ),
        ),
      ),

    );
  }
}
