import 'package:flutter/material.dart';
import 'package:realestate/screen/authentification/login.dart';
import 'package:realestate/controller/authcontroller.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController name=TextEditingController();
  TextEditingController pass=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController email=TextEditingController();
  GlobalKey<FormState> formstate=GlobalKey<FormState>();
  AuthController authController=AuthController();
  bool _isPasswordHidden = true;

  SignUp()async{
    var formData=formstate.currentState;
    if(formData!.validate()){
      var data=await authController.SignUpAuth(name.text, number.text,email.text,pass.text);
      if(data ['result']=="done"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      }else{
        showDialog(context: context, builder: (context)=>AlertDialog(
          content: Text("this email already exists"),
          title: Text('Message'),
          actions: <Widget>[
            TextButton(
                onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel',style: TextStyle(
              color: Colors.red,
            ),))

          ],
        ));
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
                              image: AssetImage('images/p3.png'),
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
                      'Signup',
                      style: TextStyle(color: Color.fromRGBO(39, 49, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),
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
                              controller: email,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
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
                              controller: number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Number",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Number is empty";
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
                              SignUp();
                            },
                            child: Text(
                              'Signup',
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
