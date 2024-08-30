import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/links.dart';

class AddEditPost extends StatefulWidget {
  final postList;
  final index;

  AddEditPost({this.index,this.postList});

  @override
  State<AddEditPost> createState() => _AddEditPostState();
}

class _AddEditPostState extends State<AddEditPost> {


  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController rooms_number=TextEditingController();
  TextEditingController price=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController address=TextEditingController();

  late  bool editMode=false;


  File? _image;
  final picker =ImagePicker();

  String? selectedCategory;
  List categoryItem=[];

  String? selectedPlace;
  List placesItem = [];


  String? author;

  getImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    } else {

      print("No image selected.");
    }
  }



  Future<void> _getAuthorFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      author = prefs.getString('name');
    });
  }


  Future getAllCategory()async{
    var url=GETALL;
    var res=await http.get(Uri.parse(url));
    if(res.statusCode==200){
      var rd=jsonDecode(res.body);
      setState(() {
        categoryItem=rd;
      });

    }
  }

  Future getAllPlaces() async {
    var url = ADDRESSALL;
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      setState(() {
        placesItem = jsonData;
      });
    }
  }


  Future addEditPost() async {
    var url = editMode ? UPDATEPOST : ADDEDITPOST;
    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields['title'] = title.text;
    request.fields['description'] = description.text;
    request.fields['rooms_number'] = rooms_number.text;
    request.fields['price'] = price.text;
    request.fields['number'] = number.text;
    request.fields['address'] = address.text;
    request.fields['category_name'] = selectedCategory!;
    request.fields['author'] = author ?? 'Unknown';
    request.fields['commune'] = selectedPlace!;


    if (editMode) {

      request.fields['id'] = widget.postList[widget.index]['id'];

    }


    if (_image != null) {
      var pic = await http.MultipartFile.fromPath('img', _image!.path, filename: _image!.path);
      request.files.add(pic);
    }


    var response = await request.send();

    if (response.statusCode == 200) {
      print("Post ${editMode ? 'updated' : 'added'} successfully.");
    } else {
      print("Failed to ${editMode ? 'update' : 'add'} post. Status code: ${response.statusCode}");
    }
  }



  @override
  void initState() {
    super.initState();
    _getAuthorFromSharedPreferences();
    getAllCategory();
    getAllPlaces();
    if(widget.index!=null){
      editMode=true;
      title.text=widget.postList[widget.index]['title'];
      description.text=widget.postList[widget.index]['description'];
      rooms_number.text=widget.postList[widget.index]['rooms_number'];
      price.text=widget.postList[widget.index]['price'];
      number.text=widget.postList[widget.index]['number'];
      address.text=widget.postList[widget.index]['address'];
      selectedCategory=widget.postList[widget.index]['category_name'];

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: ListView(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: title,
            decoration: InputDecoration(labelText: 'post title'),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: description,
            maxLines: 2,
            decoration: InputDecoration(labelText: 'post description'),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: address,
            decoration: InputDecoration(labelText: 'address'),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: rooms_number,
            decoration: InputDecoration(labelText: 'rooms number'),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: price,
            decoration: InputDecoration(labelText: 'price'),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: number,
            decoration: InputDecoration(labelText: 'number'),),
        ),



        IconButton(onPressed: (){
          getImage();
        },
            icon: Icon(Icons.image,size: 50,)),
        SizedBox(height: 10,),

        editMode? Container(child: Image.network(URL+"uploads/${widget.postList[widget.index]['img']}"),width: 100,height: 100,) :Text(''),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            height: 100,
            child: _image == null ? Center(child: Text('No image selected')) : Image.file(_image!),
          ),
        ),
        DropdownButton(
          value: selectedCategory,
          hint: Text('Select category'),
          items: categoryItem.map((category) {
            return DropdownMenuItem(
                value: category['name'],
                child: Text(category['name']));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value as String?;
            });
          },
          isExpanded: true,

        ),

        DropdownButton(
          value: selectedPlace,
          hint: Text('Select Place'),
          items: placesItem.map((item) {
            return DropdownMenuItem(
              value: item['adressname'],
              child: Text(item['adressname']),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedPlace = value as String?;
            });
          },
          isExpanded: true,
        ),


        TextButton(onPressed: (){
          addEditPost();
        }, child: Text('save'))

      ],

      ),
    );
  }
}

