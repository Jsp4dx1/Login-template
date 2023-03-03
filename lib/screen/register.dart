import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:log/model/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/screen/home.dart';

class registerSc extends StatelessWidget {
   
  @override
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  get auth => FirebaseAuth.instance;
  Profile profile = Profile(
      email: ' ',
      name: ' ',
      lastname: ' ',
      password: ' '); //เพิ่มข้อมูลใน Profile(email: ' ', password:' ');
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
             appBar: AppBar( title: Text("Register"),
              backgroundColor: Colors.black,
                 actions: [
          
          ElevatedButton.icon(
            icon: Icon(
              Icons.home,
             color: Colors.blue,
             
            ),
            label: Text(
              "",
            ),
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return homelog();
                }));
              });
            },  style: ElevatedButton.styleFrom(
                    primary: Colors.black,)
          ),
          
        ],
              
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          //   child: TextFormField(
                          //     onSaved: (String?  username){
                          //       profile.username=username!;
                          //     },
                          //     validator: RequiredValidator(errorText: "Please enter username"),
                          //     decoration: const InputDecoration(
                          //       border: UnderlineInputBorder(),
                          //       labelText: 'username',
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              onSaved: (String? email) {
                                profile.email = email!;
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please enter e-mail"),
                                EmailValidator(
                                    errorText: "Invalid e-mail format")
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'e-mail',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              onSaved: (String? password) {
                                profile.password = password!;
                              },
                              validator: RequiredValidator(
                                  errorText: "Please enter password"),
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'password',
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              onSaved: (String? name) {
                                profile.name = name!;
                              },
                              validator: RequiredValidator(
                                  errorText: "Please enter name"),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              onSaved: (String? lastname) {
                                profile.lastname = lastname!;
                              },
                              validator: RequiredValidator(
                                  errorText: "Please enter lastname"),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'lastname',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                              label: Text("Register",
                                  style: TextStyle(fontSize: 20)),
                              // color: Colors.red
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  formkey.currentState?.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: profile.email,
                                      password: profile.password,
                                    )
                                        .then((value) {
                                      formkey.currentState?.reset();
                                      Fluttertoast.showToast(
                                          msg:
                                              "Create a user account to complete.", //บรรทัดนี้ต้องใช้รูปแบบ "${}" ครอบ e.message
                                          gravity: ToastGravity.TOP);

                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return homelog();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    // print(e.code);
                                    // print(e.message);
                                    Fluttertoast.showToast(
                                        msg:
                                            "${e.message}", //บรรทัดนี้ต้องใช้รูปแบบ "${}" ครอบ e.message
                                        gravity: ToastGravity.TOP);
                                  }
                                  // print("email= ${profile.email} pass= ${profile.password}  name= ${profile.name} lastname= ${profile.lastname}");

                                }
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return ;
                                // }));
                              },
                              style: ElevatedButton.styleFrom(
                    primary: Colors.black,)
                              // style: ElevatedButton.styleFrom(
                              //   primary: Colors.black,
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
