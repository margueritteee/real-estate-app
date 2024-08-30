import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentification/login.dart';
class ProfilePage extends StatelessWidget {
  Future<Map<String, String>> _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? number = prefs.getString('number');
    String? email = prefs.getString('email');

    return {
      'name': name ?? 'No Name',
      'number': number ?? 'No Number',
      'email': email ?? 'No Email',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: CircleAvatar(
              radius: 90.0,
              backgroundImage: AssetImage('images/circle.png'),
            ),
          ),

          const SizedBox(height: 50,),
          FutureBuilder<Map<String, String>>(
            future: _getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      userInfoTile('Username:', snapshot.data!['name']!, Icons.person),
                      const SizedBox(height: 10,),
                      userInfoTile('Email:', snapshot.data!['email']!, Icons.email),
                      const SizedBox(height: 10,),
                      userInfoTile('Number:', snapshot.data!['number']!, Icons.phone),
                      const SizedBox(height: 25,),
                      logoutButton(context),
                    ],
                  );
                } else {
                  return Text('Failed to load user info');
                }
              } else {
                return Text('Failed to load user info');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget userInfoTile(String title, String subtitle, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.lightBlue.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
        ),
      ),
      child: Text('Log out'),
    );
  }
}
