import 'package:flutter/material.dart';
import 'package:realestate/controller/authcontroller.dart';
import 'package:realestate/screen/authentification/signup.dart';
import 'package:realestate/screen/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adminlogin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AuthController authController = AuthController();
  var data;

  bool _isPasswordHidden = true;

  login() async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      var result = await authController.LoginAuth(name.text, pass.text);
      setState(() {
        data = result;
      });
      if (data['result'] == "not here") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User not found"))
        );
      } else {
        SharedPreferences sph = await SharedPreferences.getInstance();
        sph.setString('userid', data['result'][0]['userid']);
        sph.setString('name', data['result'][0]['username']);
        sph.setString('number', data['result'][0]['number']);
        sph.setString('email', data['result'][0]['email']);
        sph.setString('pass', data['result'][0]['password']);
        sph.setString('login', 'login');
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
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
                padding: const EdgeInsets.all(50),
                child: Container(
                  height: 300,
                  width: 500,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/p1.png'),
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
                      'Login',
                      style: TextStyle(
                          color: Color.fromRGBO(39, 49, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(196, 135, 198, .4), blurRadius: 20, offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
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
                                border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
                            child: TextFormField(
                              controller: pass,
                              obscureText: _isPasswordHidden,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordHidden ? Icons.visibility_off : Icons.visibility),
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
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Loginadmin()));
                        },
                        child: Center(child: Text('Login as an Admin ?', style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1))))),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF1A3D9E),
                      ),
                      child: Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1A3D9E),
                            ),
                            onPressed: () {
                              login();
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Center(child: Text('Create an Account', style: TextStyle(color: Color.fromRGBO(49, 39, 79, .8))))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = prefs.getString('login');
    if (login == "login") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }
}
