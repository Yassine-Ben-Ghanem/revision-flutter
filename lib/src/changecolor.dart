import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  //var app = changeColor();
  runApp(changeColor());
}

class changeColor extends StatefulWidget {
  @override
  stateChangeC createState() {
    return stateChangeC();
  }
}

class stateChangeC extends State<changeColor> {
  Color cl = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  List<IconData> ics = [
    Icons.arrow_upward,
    Icons.arrow_back,
    Icons.arrow_downward,
    Icons.arrow_forward
  ];
  IconData ic = Icons.arrow_upward;
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("ColorIconChange"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            cl = Colors.primaries[Random().nextInt(Colors.primaries.length)];
            setState(() {});
          },
          child: Icon(Icons.restart_alt)),
      body: Column(children: [
        Row(children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              color: cl,
            ),
          ),
        ]),
        Row(children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Icon(
                ic,
                size: 100,
              ),
            ),
          ),
        ]),
        Row(children: [
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    ic = ics[Random().nextInt(ics.length)];
                    setState(() {});
                  },
                  child: Text("ChangeIcon")),
            ),
          ),
        ]),
        SizedBox(
          height: 20,
        ),
        Row(children: [
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Return")),
            ),
          ),
        ]),
      ]),
    ));
  }
}
/* validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },*/