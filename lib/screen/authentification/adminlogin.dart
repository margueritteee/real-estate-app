import 'package:flutter/material.dart';
import 'package:realestate/admin/dashboard.dart';
import 'package:realestate/controller/authcontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../admin/dashboardforadmin.dart';
class Loginadmin extends StatefulWidget {
  const Loginadmin({super.key});

  @override
  State<Loginadmin> createState() => _LoginadminState();
}

class _LoginadminState extends State<Loginadmin> {

  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AuthController authController = AuthController();
  bool _isPasswordHidden = true;

  var data;

  Login() async {
    var formData = formstate.currentState;

    if (formData!.validate()) {
      var result = await authController.LoginAdminAuth(name.text, pass.text);
      setState(() {
        data = result;
      });

      if (data['result'] == "not here") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User not found."))
        );
      } else {
        SharedPreferences sph = await SharedPreferences.getInstance();
        sph.setString('adminid', data['result'][0]['adminid']);
        sph.setString('name', data['result'][0]['username']);
        sph.setString('pass', data['result'][0]['password']);
        if (name.text == 'admin' && pass.text == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formstate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 400,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 400,
                          width: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/p2.png'),

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Login As Admin',
                      style: TextStyle(color: Color.fromRGBO(39, 49, 79, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(196, 135, 198, .4),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.grey[300]!))),
                            child: TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Username is empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.grey[300]!))),
                            child: TextFormField(
                              controller: pass,
                              obscureText: _isPasswordHidden,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Password is empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:Color(0xFF1A3D9E),
                      ),
                      child: Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1A3D9E),
                            ),
                            onPressed: () {
                              Login();
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
