import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:realestate/constant/links.dart';
class adminsPage extends StatefulWidget {
  const adminsPage({super.key});

  @override
  State<adminsPage> createState() => _adminsPageState();
}

class _adminsPageState extends State<adminsPage> {

  TextEditingController name=TextEditingController();
  TextEditingController pass=TextEditingController();
  List list=[];

  Future readData() async {
    var url = READADMINS;
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var rd = jsonDecode(res.body);
      setState(() {
        list = rd;
      });
      _streamController.add(list);
    }
  }


  Future addData() async {
    var url = ADDADMINS;
    var res = await http.post(Uri.parse(url), body: {
      'name': name.text,
      'pass': pass.text
    });
    if (res.statusCode == 200) {
      readData();
    }
  }


  Future editData(id) async {
    var url = EDITADMINS;
    var res = await http.post(Uri.parse(url), body: {
      'id': id,
      'name': name.text,
      'pass': pass.text
    });
    if (res.statusCode == 200) {
      readData();
    }
  }


  Future deleteData(id) async {
    var url = DELETEADMINS;
    var res = await http.post(Uri.parse(url), body: {
      'id': id
    });
    if (res.statusCode == 200) {
      readData();
    }
  }



  late StreamController<List<dynamic>> _streamController;
  late Stream<List<dynamic>> _stream;
  @override
  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<dynamic>>();
    _stream = _streamController.stream;
    readData();
  }


  getData()async{
    await readData();
  }

  addAdmin()async{
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          height: 300,
          child: Column(
            children: [
              TextFormField(
                controller: name,
              ),
              TextFormField(
                controller: pass,
              ),
              ElevatedButton(onPressed: (){
                addData();
                readData();
                Navigator.pop(context);
              }, child: Text('Add')),
            ],
          ),
        ),
      );
    });
  }

  editAdmin(id)async{
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          height: 300,
          child: Column(
            children: [
              TextFormField(
                controller: name,
              ),
              TextFormField(
                controller: pass,
              ),
              ElevatedButton(onPressed: (){
                editData(id);
                readData();
                Navigator.pop(context);
              }, child: Text('Update')),
            ],
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('admins list'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(onPressed: () {
              addAdmin();
            },
                icon: Icon(Icons.add, size: 30,))
          ],
        ),
        body: StreamBuilder<List<dynamic>>(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(snapshot.data![i]['username']),
                  subtitle: Text('password: ${snapshot.data![i]['password']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>
                            editAdmin(snapshot.data![i]['adminid']),
                        icon: Icon(Icons.edit),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () =>
                            deleteData(snapshot.data![i]['adminid']),
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }}