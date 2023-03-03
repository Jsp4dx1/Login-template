import 'package:flutter/material.dart';
import 'package:log/screen/register.dart';

import 'login.dart';

class homelog extends StatelessWidget {
  const homelog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(
      //     title:Image.asset(
      //   "assets/img/logow.png",
      //   fit: BoxFit.contain,
      //   height: 50,
      // ),
      //     backgroundColor: Colors.black,
      //   ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 90, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset("assets/img/logo 2.png"),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                margin: EdgeInsets.all(5),
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.login,
                    color: Colors.blue.shade400,
                  ),
                  label: Text("Login",
                      style: TextStyle(fontSize: 20, )),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return loginSc();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.red,
                  ),
                  label: Text("Register",
                      style: TextStyle(fontSize: 20, )),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return registerSc();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
