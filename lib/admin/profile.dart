import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  final String name;
  final String number;
  final String  password;

  profile({required this.name, required this.number, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
        ),
        backgroundColor:Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundColor: Colors.blueGrey,
                child: Text(
                  name.isNotEmpty ? name.substring(0, 2).toUpperCase() : '?',
                  style: TextStyle(fontSize: 50.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Name: $name",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                "Number: $number",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                "Password: $password",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
