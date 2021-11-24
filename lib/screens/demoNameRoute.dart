import 'package:flutter/material.dart';
import 'package:roccabox_admin/agora/callModel.dart';

class ExampleRoute extends StatefulWidget {

  static const routeName = '/extractArguments';
  ExampleRoute({Key? key}) : super(key: key);
  @override
  _ExampleRouteState createState() => _ExampleRouteState();
}

class _ExampleRouteState extends State<ExampleRoute> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CallModel;
    return Scaffold(
      body: Column(
        children: [
          Text(args.sender_name),
          Text(args.sender_id)
        ],
      ),
    );
  }
}
