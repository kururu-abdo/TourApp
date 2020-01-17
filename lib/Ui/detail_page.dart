import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tourapp/Models/location_models.dart';

class Details extends StatelessWidget{
  final String  desc;
final String pic;
  const Details({Key key, this.desc ,
  this.pic}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;
    var size =MediaQuery.of(context).size ;
   final double itemHeight = size.height ;
    final double itemWidth = size.width;
    // TODO: implement build
    return Scaffold(
appBar: AppBar(
  title: Text("Details"),

  leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 40.0,
           
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
), ) ,
          body: Stack(
children: <Widget>[
  Container(
    height: itemHeight ,
    width: itemWidth,
   decoration: BoxDecoration(
       image: DecorationImage(
        
         image: MemoryImage(base64.decode(pic)   ),
         fit: BoxFit.fitHeight,
       ),
   ),

//    child:PhotoView(
//imageProvider: MemoryImage((base64.decode(pic)),
//
//
         // ) ,


//                    initialScale: PhotoViewComputedScale.contained * 0.8,
//                     maxScale: PhotoViewComputedScale.covered * 2,
//        enableRotation: true,
//        // Set the background color to the "classic white"
//        backgroundDecoration: BoxDecoration(
//          color: Theme.of(context).canvasColor,
//        ),
//        loadingChild: Center(
//          child: CircularProgressIndicator(),
//        ),

          
           ) ,
           
          



Positioned(
bottom: itemHeight*.20,
  left: 10.0,
  right: 10.0 ,
  

  child:   Card(

    color: Colors.teal[500],  
      elevation: 8.0,
  
      shape: RoundedRectangleBorder(
  
        borderRadius: BorderRadius.circular(8.0),
  
      ),
  
      child: Column(
  
        children: <Widget>[
  
          Padding(
  
            padding: const EdgeInsets.all(16.0),
  
            
  
          ),
  
          Padding(
  
            padding: const EdgeInsets.all(16.0),
  
            child: Column(

              children: <Widget>[


  SingleChildScrollView(child: Text( desc)    )
              ],
            
              
              
              ),
              
              )
  
  
  
        ],
  
      ),
  
  ),
),


],

      ),
    );
  }


}