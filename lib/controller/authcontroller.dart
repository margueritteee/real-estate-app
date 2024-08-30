import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:realestate/constant/links.dart';

class AuthController {
  Future LoginAuth(name, pass) async {
    var url = LOGIN;
    var res = await http.post(Uri.parse(url), body: {
      "name": name,
      "pass": pass,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    }
  }

  Future LoginAdminAuth(name, pass) async {
    var url = LOGINADMIN;
    var res = await http.post(Uri.parse(url), body: {
      "name": name,
      "pass": pass,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    }
  }

  Future SignUpAuth(name,number,email,pass)async{
    var url=SIGNUP;
    var res=await http.post(Uri.parse(url),body: {
      "name":name,
      "number":number,
      "email":email,
      "pass":pass
    },);
  if(res.statusCode==200){
    var data=jsonDecode(res.body);
    return data;
  }
  }

}
