import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:realestate/constant/links.dart';
class categoryPage extends StatefulWidget {
  const categoryPage({super.key});

  @override
  State<categoryPage> createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {

  TextEditingController name=TextEditingController();
  List list=[];

  Future readData()async{
    var url=GETALL;
    var res=await http.get(Uri.parse(url));
    if(res.statusCode==200){
      var rd=jsonDecode(res.body);
      setState(() {
        list.addAll(rd);
        _streamController.add(rd);
      });
      print(list);
    }
  }

  Future addData()async{
    var url=ADDCATEGORY;
    var res=await http.post(Uri.parse(url),body: {
      'name':name.text
    });
    if(res.statusCode==200){
      var rd=jsonDecode(res.body);
      print(rd);
    }
  }

  Future editData(id)async{
    var url=EDITCATEGORY;
    var res=await http.post(Uri.parse(url), body:{
    'id':id,
     'name':name.text
    });
    if(res.statusCode==200){
      var rd=jsonDecode(res.body);
      print(rd);
    }

  }

  Future deleteData(id)async{
    var url=DELETECATEGORY;
    var res=await http.post(Uri.parse(url),body: {
      'id':id
    });
    if(res.statusCode==200){
      var rd=jsonDecode(res.body);
      print(rd);
    }
  }


  late StreamController<List<dynamic>> _streamController;
  late Stream<List<dynamic>> _stream;
  @override
  void initState() {
    super.initState();

    setState(() {
      _streamController=StreamController();
      _stream=_streamController.stream;
    });

    getData();
  }

  getData()async{
    await readData();
  }

  addCategory()async{
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          height: 300,
          child: Column(
            children: [
              TextFormField(
                controller: name,
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

  editCategory(id)async{
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          height: 300,
          child: Column(
            children: [
              TextFormField(
                controller: name,
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
      appBar: AppBar(title: Text('category page'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){
            addCategory();
          },
              icon: Icon(Icons.add, size: 30,))
        ],
      ),
      body:StreamBuilder<List<dynamic>>(
          stream: _stream,
          builder: (stx,snp){

            if(!snp.hasData){
              return Container(
                child: Text('no data'),
              );
            }
            else if(snp.hasError){
              return CircularProgressIndicator();
            }
            else {
              return ListView.builder(
                itemCount: snp.data!.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snp.data![i]['name']),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: () {
                            editCategory(snp.data![i]['id']);
                            readData();
                          }, icon: Icon(Icons.edit), color: Colors.green,),
                          IconButton(onPressed: () {
                            deleteData(snp.data![i]['id']);
                            readData();
                          }, icon: Icon(Icons.delete), color: Colors.red,),

                        ],
                      ),
                    ),
                  );
                },

              );
            }
      })
    );
  }
}
