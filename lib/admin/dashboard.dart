import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/admin/adminsPage.dart';
import 'package:realestate/admin/categoryPage.dart';
import 'package:realestate/admin/postInfos.dart';
import 'package:realestate/admin/profile.dart';
import 'package:realestate/constant/links.dart';
import 'package:realestate/screen/authentification/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  List list = [];

  ///--------------- Read Data ------------
  Future readData() async {
    var url = READDATA;
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      setState(() {
        list.addAll(red);
        _streamController.add(red);
      });
      print(list);
    }
  }

  ///--------------- Add Data ------------
  Future addData() async {
    var url = ADDDATA;
    var res = await http.post(Uri.parse(url), body: {
      'name': name.text,
      'number': number.text,
      'password': password.text,
    });
    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);
      if (red == "done") {
        name.clear();
        number.clear();
        password.clear();
        readData();
      }
      print(red);
    }
  }

  Future editData(id) async {
    var url = EDITDATA;
    var res = await http.post(Uri.parse(url), body: {
      'id': id,
      'name': name.text,
      'number': number.text,
      'password': password.text,
    });
    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);
      print(red);
      await readData(); // Ensure to read the updated data after editing
    }
  }


  Future deleteData(id) async {
    var url = DELETEDATA;
    var res = await http.post(Uri.parse(url), body: {'id': id});
    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);
      print(red);
    }
  }

  List Data = [];
  Future Suggestion() async {
    var url = SUGGESTIONS;
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      for (int i = 0; i < data.length; i++) {
        setState(() {
          Data.add(data[i]['username']);
        });
      }
    }
    print(Data);
  }

  late StreamController<List<dynamic>> _streamController;
  late Stream<List<dynamic>> _stream;

  @override
  void initState() {
    super.initState();
    setState(() {
      _streamController = StreamController();
      _stream = _streamController.stream;
    });
    Suggestion();
    getData();
  }

  getData() async {
    await readData();
  }

  addUsers() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 350.0,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: number,
                  decoration: InputDecoration(labelText: 'Number'),
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    print(name.text);
                    print(number.text);
                    print(password.text);
                    addData();
                    readData();
                    Navigator.pop(context);
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  editUsers(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 350.0,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: number,
                  decoration: InputDecoration(labelText: 'Number'),
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    print(name.text);
                    print(number.text);
                    print(password.text);
                    await editData(id);
                    await readData();
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.account_circle, size: 40,),
              title: Text('Users', style: TextStyle(
                fontSize: 20,
              ),),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle,size: 40,),
              title: Text('Admins', style: TextStyle(
                fontSize: 20,
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => adminsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.category,size: 40,),
              title: Text('Category', style: TextStyle(
                fontSize: 20,
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => categoryPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.post_add,size: 40,),
              title: Text('Post', style: TextStyle(
                fontSize: 20,
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => postInfos(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red,size: 40,),
              title: Text('Logout', style: TextStyle(
                fontSize: 20,
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Users List'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUsers(data: Data));
            },
            icon: Icon(Icons.search, size: 35.0),
          ),
          IconButton(
            onPressed: () {
              addUsers();
            },
            icon: Icon(Icons.add, size: 35.0),
          ),
        ],
      ),
      body: StreamBuilder<List<dynamic>>(
        stream: _stream,
        builder: (stx, snp) {
          if (!snp.hasData) {
            return Container(
              child: Text("No data"),
            );
          } else if (snp.hasError) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snp.data!.length,
              itemBuilder: (ctx, i) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => profile(
                            name: snp.data![i]['username'],
                            number: snp.data![i]['number'],
                            password: snp.data![i]['password'],
                          ),
                        ),
                      );
                    },
                    title: Text(snp.data![i]['username']),
                    subtitle: Text("Number: ${snp.data![i]['number']}\nPassword: ${snp.data![i]['password']}"),
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.teal,
                      child: Text(
                        style: TextStyle(color: Colors.white),
                        snp.data![i]['username']
                            .toString()
                            .substring(0, 2)
                            .toUpperCase(),
                      ),
                    ),
                    trailing: Container(
                      width: 100.0,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              editUsers(snp.data![i]['userid']);
                            },
                            icon: Icon(Icons.edit, color: Colors.teal),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteData(snp.data![i]['userid']);
                              readData();
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class SearchUsers extends SearchDelegate {
  List data = [];
  SearchUsers({required this.data});

  Future GetUsersData() async {
    var url = SEARCH;
    var res = await http.post(Uri.parse(url), body: {"query": query});
    if (res.statusCode == 200) {
      var userdata = jsonDecode(res.body);
      return userdata;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: GetUsersData(),
      builder: (stx, snp) {
        if (!snp.hasData) {
          return Center(child: Text('No data'));
        } else if (snp.hasError) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snp.data.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => profile(
                        name: snp.data![index]['username'],
                        number: snp.data![index]['number'],
                        password: snp.data![index]['password'],
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.teal,
                  child: Text(
                    style: TextStyle(color: Colors.white),
                    snp.data![index]['username']
                        .toString()
                        .substring(0, 2)
                        .toUpperCase(),
                  ),
                ),
                title: Text('${snp.data[index]['username']}'),
                subtitle: Text(
                    'Number: ${snp.data[index]['number']}\nPassword: ${snp.data[index]['password']}'),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var datasuggestion = query.isEmpty
        ? data
        : data
        .where((element) =>
        element.toString().toLowerCase().contains(query))
        .toList();
    return ListView.builder(
      itemCount: datasuggestion.length,
      itemBuilder: (ctn, index) {
        return ListTile(
          onTap: () {
            query = datasuggestion[index];
            showResults(context);
          },
          leading: Icon(Icons.person),
          title: Text('${datasuggestion[index]}'),
        );
      },
    );
  }
}
