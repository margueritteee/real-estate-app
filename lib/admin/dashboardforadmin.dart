import 'package:flutter/material.dart';
import 'package:realestate/admin/categoryPage.dart';
import 'package:realestate/admin/postInfos.dart';
import 'package:realestate/screen/authentification/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String? username;

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30,),
            ListTile(
              leading: Icon(Icons.category, size: 40,),
              title: Text('Category', style: TextStyle(
                fontSize: 20,
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => categoryPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.post_add, size: 40,),
              title: Text('Post', style: TextStyle(
                fontSize: 20,
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => postInfos(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red,size: 40,),
              title: Text('Logout', style: TextStyle(
                fontSize: 20,
              ),),
              onTap: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.clear();
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(username != null ? "Welcome to the Admin Dashboard, $username!" : "Loading..."),
      ),
    );
  }
}
