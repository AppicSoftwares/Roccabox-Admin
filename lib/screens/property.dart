import 'package:flutter/material.dart';



class Property extends StatefulWidget {
  const Property({ Key? key }) : super(key: key);

  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text("Property Page")),
      
    );
  }
}