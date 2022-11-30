import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fp26/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user);
    } else {
      print("null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              color: Colors.blueGrey,
              child: Text("${user!.photoURL}"),
            )),
            ListTile(
              title: Text("${user!.email}"),
            ),
            ListTile(
              title: Text("${user!.displayName}"),
            ),
            ListTile(
              onTap: () async {
                await GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut().then((value) => {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return login();
                        },
                      ))
                    });
              },
              title: Text("Log Out"),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Text("""WelCome  ${user!.displayName} 
    to our application..."""),
            ),
          )
        ],
      )),
    );
  }
}
