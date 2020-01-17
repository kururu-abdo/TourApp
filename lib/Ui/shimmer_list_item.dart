import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListItem extends StatelessWidget {
  final int index;
  const ListItem({Key key, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          // Container(
          //   width: 50.0,
          //   height: 50.0,
          //   margin: EdgeInsets.only(right: 15.0),
          //   color: Colors.blue,
          // ),
          index != -1
           ?ListTile(
title:Text(
                      'This is title $index',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ) ,
subtitle: Text('This is more details'),
leading: Icon(MdiIcons.album),


           )
              // Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         'This is title $index',
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //       Text('This is more details'),
              //       Text('One more detail'),
              //     ],
              //   )
              : Expanded(
                  child: Container(
       
                    color: Colors.pinkAccent[700],
                  ),
                )
        ],
      ),
    );
  }
}
