import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/screen/SelectPlaceBy.dart';
import '../constant/links.dart';
class PlaceListItem extends StatefulWidget {
  const PlaceListItem({super.key});

  @override
  State<PlaceListItem> createState() => _PlaceListItemState();
}

class _PlaceListItemState extends State<PlaceListItem> {
  List places= [];
  Future getAllPlace()async{
    var url=ADDRESSALL;
    var response=await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var jsonData=json.decode(response.body);
      setState(() {

        places=jsonData;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getAllPlace();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:places.length,
          itemBuilder:(context,index){
            return PlaceItem(
              placeName: places[index]['adressname'],
            );
          }
      ),
    );
  }
}

class PlaceItem extends StatefulWidget {
  final placeName;
  PlaceItem({this.placeName});

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => SelectPlaceBy(placeName: widget.placeName),
      )),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.only(left: 9, bottom: 5,top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.placeName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}


