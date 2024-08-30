import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/admin/addEditPost.dart';
import 'package:realestate/constant/links.dart';
class postInfos extends StatefulWidget {
  const postInfos({super.key});

  @override
  State<postInfos> createState() => _postInfosState();
}

class _postInfosState extends State<postInfos> {

  List post=[];
  String? username;

  Future getAllPosts()async{
    var url=POSTALL;
    var res=await http.get(Uri.parse(url));
    if(res.statusCode==200){
      var rd=jsonDecode(res.body);
      setState(() {
        post=rd;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await getAllPosts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPost())).whenComplete(() {
              getAllPosts();
            });
          }, icon: Icon(Icons.add,size: 30,))
        ],
        title: Text('post details'),
      ),
      body: ListView.builder(
        itemCount: post.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: 300,
                height: 250,
                padding: EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Positioned(
                      child: Text(
                        post[index]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      top: 7,
                      left: 8,
                    ),
                    Positioned(
                      child: Text(
                        post[index]['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      top: 48,
                      left: 8,
                      right: 8,
                    ),
                    Positioned(
                      child: Text(
                        "Rooms number: ${post[index]['rooms_number']}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      top: 28,
                      left: 8,
                      right: 8,
                    ),
                    Positioned(
                      child: Text(
                        post[index]['price'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      top: 88,
                      left: 8,
                      right: 8,
                    ),
                    Positioned(
                      child: Text(
                        post[index]['number'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      top: 108,
                      left: 8,
                      right: 8,
                    ),
                    Positioned(
                      child: Text(
                        post[index]['address'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      top: 130,
                      left: 8,
                      right: 8,
                    ),
                    Positioned(
                      child: Text(
                        post[index]['category_name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      top: 150,
                      left: 8,
                      right: 8,
                    ),
                    Positioned(
                      child: Text("Posted by: ${post[index]['author']}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      top: 170,
                      left: 8,
                      right: 8,
                    ),
                    Positioned(
                      child: Text("In: ${post[index]['commune']}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      top: 190,
                      left: 8,
                      right: 8,
                    ),
                    Container(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditPost(
                                      postList: post,
                                      index: index,
                                    ),
                                  ),
                                ).whenComplete(() {
                                  getAllPosts();
                                });

                            },
                            icon: Icon(Icons.edit, color: Colors.green),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(context: (context), builder: (context)=> AlertDialog(
                              title: Text('message'),
                                content: Text('are you sure you want to delete?'),
                                actions:[

                                  TextButton(
                                      onPressed: (){
                                    Navigator.pop(context);
                                    setState(() {
                                    });
                                  }, child: Text('cancel')),
                                  TextButton(
                                      onPressed: ()async{
                                    var url=DELETEPOST;
                                    var response=await http.post(Uri.parse(url), body: {
                                      "id":post[index]['id']
                                    });
                                    if (response.statusCode==200){

                                      setState(() {
                                        getAllPosts();
                                      });
                                      Navigator.pop(context);
                                    }
                                  }, child: Text('confirm')),
                                ],
                                ));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
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
        },

      ),
    );
  }
}
