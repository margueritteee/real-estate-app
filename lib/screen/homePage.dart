import 'dart:convert';


import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realestate/screen/placeslistitem.dart';
import 'package:realestate/screen/postDetails.dart';
import 'package:realestate/screen/categorylistitem.dart';
import 'package:realestate/screen/profilePage.dart';
import 'package:realestate/screen/recentpostitem.dart';
import 'package:realestate/screen/topPostCard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/links.dart';



class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  List searchList = [];

  Future<void> showAllPost() async {
    var url = POSTALL;
    var response = await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for(var i=0;i<jsonData.length;i++){
       searchList.add(jsonData[i]['title']);
      }
      print(searchList);
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAllPost();
    GetData();

  }
  GetData()async{
    await GetShared();
  }
  var name;
  var userid;
  var number;
  GetShared()async{
    SharedPreferences sph= await SharedPreferences.getInstance();
    setState(() {
      userid=sph.get('userid');
      name=sph.get('name');
      number=sph.get('number');
    });

  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(),
      ProfilePage(),
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.blue.shade100,
        elevation: 1,
        actions: <Widget>[
         IconButton(onPressed: (){
           showSearch(context: context, delegate: SearchPost(data: searchList));

         }, icon: Icon(Icons.search,size: 30,)),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.lightBlue.shade100,
        backgroundColor: Colors.white,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Text(
              'Categories:',
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'BalanceGroovy-Sans',
              ),
            ),
          ),
        ),
        CategoryListItem(),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Text(
              'Places:',
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'BalanceGroovy-Sans',
              ),
            ),
          ),
        ),
         PlaceListItem(),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Real estate posts:',
            style: TextStyle(
              fontSize: 25.0,
              fontFamily: 'BalanceGroovy-Sans',
            ),
          ),
        ),
        TopPostCard(),
        Container(
          height: 250,
          child: RecentPostItem(),
        ),
      ],
    );
  }
}





class SearchPost extends SearchDelegate{
  List data=[];
  SearchPost({required this.data});

  Future GetPostData()async{
    var url=SEARCHPOST;
    var res =await http.post(Uri.parse(url),body: {
      "query":query
    });
    if(res.statusCode==200){
      var postdata=jsonDecode(res.body);
      return postdata;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(onPressed: (){
        query=''; // tm7ilna el ktiba
      },
        icon:Icon(Icons.close),)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(onPressed: (){
        close(context, null); //trj3na lel page
      },
        icon:Icon(Icons.arrow_back),);

  }

  @override
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: GetPostData(),
        builder: (ctx, snp) {
          if (snp.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else if (snp.hasError) {
            return Center(child: Text('Error: ${snp.error}'));
          } else if (!snp.hasData || snp.data.isEmpty) {
            return Center(child: Text('No data'));
          } else {
            return ListView.builder(
                itemCount: snp.data.length,
                itemBuilder: (ctx, index) {
                  var post = snp.data[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetails(
                            title: post['title'],
                            img:URL+"uploads/${post['img']}",
                            description: post['description'],
                            category_name: post['category_name'],
                            author: post['author'],
                            rooms_number: post['rooms_number'].toString(),
                            address: post['address'],
                            number: post['number'],
                            price: post['price'].toString(),
                            commune: post['commune'],

                          ),
                        ),
                      );
                    },
                    title: Text('${post['title']}'),
                    subtitle: Text('${post['address']}'),
                  );
                });
          }
        }
    );
  }



  @override // suggestions li aendi fel liste
  Widget buildSuggestions(BuildContext context) {
    //ida kant empty a3tilna data kaml ida lala a3tilna element li nhwso elih (query) fi forme liste
    var datasuggestion=query.isEmpty? data : data.where((element) => element.toString().toLowerCase().contains(query)).toList();
    return ListView.builder(
        itemCount: datasuggestion.length,
        itemBuilder: (ctn,index){
          return ListTile(
            onTap: (){
              query=datasuggestion[index]; // ki nclicki ela wahd ywli fel query
              showResults(context);
            },
            leading: Icon(Icons.house),
            title: Text('${datasuggestion[index]}'),
          );
        }

    );
  }


}
