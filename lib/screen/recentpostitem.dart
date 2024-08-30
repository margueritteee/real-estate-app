import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/screen/postDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/links.dart';

class RecentPostItem extends StatefulWidget {



  @override
  State<RecentPostItem> createState() => _RecentPostItemState();
}

class _RecentPostItemState extends State<RecentPostItem> {
  List recentPost = [];

  Future<void> recentPostData() async {
    var url = POSTALL;
    var response = await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        recentPost = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    recentPostData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          itemCount: recentPost.length,
          itemBuilder: (context,index){
            return RecentItem(
              category_name: recentPost[index]['category_name'],
              author: recentPost[index]['author'],
              title: recentPost[index]['title'],
              rooms_number: recentPost[index]['rooms_number'],
              description: recentPost[index]['description'],
              address: recentPost[index]['address'],
              number: recentPost[index]['number'],
              price: recentPost[index]['price'],
              img: URL + "uploads/${recentPost[index]['img']}",
              commune: recentPost[index]['commune'],
            );
          }
      ),
    );
  }
}
class RecentItem extends StatefulWidget {
  final category_name;
  final author;
  final img;
  final title;
  final rooms_number;
  final description;
  final address;
  final number;
  final price;
  final commune;
  RecentItem({this.commune,this.rooms_number, this.price, this.img, this.description, this.category_name, this.author, this.address, this.number, this.title});

  @override
  State<RecentItem> createState() => _RecentItemState();
}

class _RecentItemState extends State<RecentItem> {
  String? userid;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  void loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostDetails(
                              title: widget.title,
                              img: widget.img,
                              category_name: widget.category_name,
                              price: widget.price,
                              author: widget.author,
                              number: widget.number,
                              address: widget.address,
                              rooms_number: widget.rooms_number,
                              description: widget.description,
                              commune: widget.commune,
                            ),
                      ),
                    );
                  },

                  child:
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.address),
                    SizedBox(width: 20),
                    Text(widget.price),
                    SizedBox(width: 10),


                  ],
                ),
              ),

            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Image.network(
              widget.img,
              height: 70,
              width: 70,
            ),
          ),
        ],
      ),
    );
  }
}
