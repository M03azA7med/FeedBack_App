import 'package:feedback/viewFeedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'feedback.dart';


class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  bool securetext = true;
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('feedback customer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.deepOrange),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',labelStyle: TextStyle(color: Colors.deepOrange),
                        hintText: 'enter your email',
                        prefixIcon: Icon(Icons.account_circle_outlined,color: Colors.deepOrange,),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange
                            )
                        ),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please enter email' : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(

                      controller: passwordController,
                      obscureText: securetext,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange
                            )
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              securetext = !securetext;
                            });
                          },
                          icon: Icon(securetext
                              ? Icons.visibility
                              : Icons.visibility_off,color: Colors.deepOrange),
                        ),
                        labelText: 'Password',labelStyle: TextStyle(color: Colors.deepOrange),
                        hintText: 'enter your Password',
                        prefixIcon: const Icon(Icons.lock,color: Colors.deepOrange,),
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please enter Password' : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () async {
                        formkey.currentState!.validate();
                        try {
                          // isloading=true;
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if(emailController.text=="admin_owner@oscar.com"){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => viewFeedback(),));
                            print("================== $emailController");
                          }else{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => feedback(),));
                            print("================== $emailController");
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
