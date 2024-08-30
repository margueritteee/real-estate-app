import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/constant/links.dart';
import 'package:realestate/screen/postDetails.dart';
class SelectCategoryBy extends StatefulWidget {

  final categoryName;
  SelectCategoryBy({this.categoryName});

  @override
  State<SelectCategoryBy> createState() => _SelectCategoryByState();
}

class _SelectCategoryByState extends State<SelectCategoryBy> {

  List categoryByPost=[];
Future categoryByData()async{
  var url=CATEGORY;
  var response=await http.post(Uri.parse(url),body: {
    'name':widget.categoryName
  });
  if(response.statusCode==200){
    var jsonData=json.decode(response.body);
    setState(() {
      categoryByPost=jsonData;
    });
  }
}
@override
  void initState() {
    categoryByData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Container(child: ListView.builder(
           itemCount: categoryByPost.length,
          itemBuilder: (context,index){
        return  NewPostItem(
          category_name: categoryByPost[index]['category_name'],
          author: categoryByPost[index]['author'],
          img: URL+'uploads/${categoryByPost[index]['img']}',
          title: categoryByPost[index]['title'],
          rooms_number: categoryByPost[index]['rooms_number'],
          description: categoryByPost[index]['description'],
          address: categoryByPost[index]['address'],
          number: categoryByPost[index]['number'],
          price: categoryByPost[index]['price'],
          commune: categoryByPost[index]['commune'],
        );
      }),),
    );
  }
}
class NewPostItem extends StatefulWidget {
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
  NewPostItem({this.commune,this.rooms_number,this.price,this.img,this.description,this.category_name,this.author,this.address,this.number,this.title});


  @override
  State<NewPostItem> createState() => _NewPostItemState();
}

class _NewPostItemState extends State<NewPostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              height: 200,
              width: MediaQuery.of(context).size.width *
                  0.4, // Half of the screen width
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: MediaQuery.of(context).size.width * 0.4 + 10, // Positioned right after the image
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ActaDisplayBook',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.address,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'ActaDisplayBook',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 80,
              left: MediaQuery.of(context).size.width * 0.4 + 10,
              child: Text(
                widget.price,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'ActaDisplayBook',

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: MediaQuery.of(context).size.width * 0.4 + 10,
              child: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
            ),
            Positioned(
              bottom: 32,
              left: MediaQuery.of(context).size.width * 0.4 + 33,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetails(
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
                child: Text(
                  'Read more',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
