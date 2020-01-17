import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class mapPage extends StatefulWidget {
  final double latitude;
    final double longitude;
    final String location;
  mapPage(this.latitude, this.longitude ,this.location);



  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<mapPage> {
  

Completer<WebViewController>  controller =Completer<WebViewController> ();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location),
      ),
       body: WebView(
onWebViewCreated: (WebViewController c){
  controller.complete(c);
  
},
gestureRecognizers: Set()
..add(Factory<VerticalDragGestureRecognizer>(
  ()=>VerticalDragGestureRecognizer()
)),
javascriptMode: JavascriptMode.unrestricted,

initialUrl: 'http://maps.google.com/maps?q=${widget.latitude},${widget.longitude}',
       ),

floatingActionButton: showPageInfo(),
      
    );
  }

   showPageInfo() {
return FutureBuilder<WebViewController>(
  future: controller.future,
 
  builder: (BuildContext context,   AsyncSnapshot<WebViewController> snapshot) {
    if(snapshot.hasData){
 return  FloatingActionButton(
        onPressed: () async{
var url = await snapshot.data.currentUrl();


Scaffold.of(context).showSnackBar(
  SnackBar(
    content:  Text('the current url is $url'),
  )
);

        },
child: Icon(Icons.info),

      );


    }
   
  },
);


  }
}