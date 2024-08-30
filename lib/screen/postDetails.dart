import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
class PostDetails extends StatelessWidget {
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

  PostDetails({
    this.commune,
    this.rooms_number,
    this.price,
    this.img,
    this.description,
    this.category_name,
    this.author,
    this.address,
    this.number,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children:<Widget> [
              Container(  child: Image.network(img,fit: BoxFit.cover,),
              height:screenHeight*0.4 ,
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight*0.3),
                child: Material(
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(100.0) ,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 40,top: 30,right: 20,bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget> [
                        Text(title,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontFamily: 'ActaDisplayBook',
                        ),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Price:  ' , style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'ActaDisplayBook',
                            ),),
                            Text(price, style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontFamily: 'ActaDisplayBook',
                            ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rooms Number:'),
                            Row(
                              children: [
                                Text(rooms_number, style: TextStyle(
                                  fontSize: 20
                                ),),
                                SizedBox(width: 5,),
                                Icon(Icons.bedroom_child_outlined),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Divider(),
                        SizedBox(height: 20,),
                        Text(description, style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.place, color: Colors.blue,),
                            Text('Adress : '+ address),
                            SizedBox(width: 10,),
                            Text('In :'+ commune),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Divider(),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.real_estate_agent, color: Colors.blue,),
                            Text('Agency :  ' + author ,),
                            SizedBox(width: 10,),
                            Text('Category :'+ category_name),
                          ],
                        ),
                        SizedBox(height: 40,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.phone, color: Colors.blue, size: 30,),
                                SizedBox(width: 10,),
                                Text(number , style: TextStyle(fontSize: 20),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [

                            Expanded(
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                  ),
                                  color: Colors.lightBlueAccent.withOpacity(.4),
                                ),
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () async {
                                    final Uri smsUrl = Uri.parse("sms:$number");
                                    if (await canLaunchUrl(smsUrl)) {
                                      await launchUrl(smsUrl);
                                    } else {
                                      print('Could not launch $smsUrl');
                                    }
                                  },
                                  child: Text('Message me', style: TextStyle(color: Colors.blue)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                  ),
                                  color: Colors.blue,
                                ),
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () async {
                                    final Uri telephoneUrl = Uri.parse("tel:$number");
                                    if (await canLaunchUrl(telephoneUrl)) {
                                      await launchUrl(telephoneUrl);
                                    } else {
                                      print('Could not launch $telephoneUrl');
                                    }
                                  },
                                  child: Text('Call me', style: TextStyle(color: Colors.white),

                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
}