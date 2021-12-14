import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ajout.dart';
import 'changecolor.dart';
import 'list.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'app7',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'APP7'),
        routes: {
          "/ajout": (context) => ajoutt(),
          "/colors": (context) => changeColor(),
          '/ListArticle': (context) => MyListArticle(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Yassine ben ghanem"),
              accountEmail: Text("benghanem1999@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("img.png"),
              ),
            ),
            ListTile(
                trailing: Icon(Icons.add),
                title: const Text('Ajouter Article'),
                onTap: () {
                  Navigator.pushNamed(context, "/ajout");
                }),
            ListTile(
              title: const Text('Change Color'),
              onTap: () {
                Navigator.pushNamed(context, "/colors");
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Exit'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('List article'),
              trailing: const Icon(Icons.featured_play_list_outlined),
              onTap: () {
                Navigator.pushNamed(context, '/ListArticle');
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  button1(),
                  SizedBox(height: 30),
                  AlertDialog1(),
                  SizedBox(height: 30),
                  AlertDialog2(),
                ],
              ))),
    );
  }

  Widget button1() {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.red),
      ),
      child: Row(
        children: [
          Icon(Icons.view_in_ar, size: 36),
          Text("SnackBar exemple"),
        ],
      ),
      onPressed: () {
        final snackBar = SnackBar(
          content: const Text('Email delaited!'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.purple,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  Widget AlertDialog1() {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.green),
      ),
      child: Row(
        children: [
          Icon(Icons.view_list, size: 36),
          Text("Alert Dialogue exemple"),
        ],
      ),
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const Text('AlertDialog description'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget AlertDialog2() {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.green),
      ),
      child: Row(
        children: [
          Icon(Icons.view_quilt, size: 36),
          Text("Alert Dialogue exemple"),
        ],
      ),
      onPressed: () {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(children: [
                  Image.asset(
                    'img.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const Text('AlertDialog Title'),
                ]),
                content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      },
    );
  }

  Widget listview() {
    return ListView.builder(
        itemCount: 25,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.black12,
            child: ListTile(
              title: Text("Article nume ${index + 1}"),
              subtitle: Text("Description Article nume${index + 1}"),
            ),
          );
        });
  }

  void loadArticle() {
    List listProduitFromJson = [];
    Future<String?> loadFile() async {
      String contenu = await rootBundle.loadString('data/list_articlesjson');
      List datajson = jsonDecode(contenu);
      setState(() {
        listProduitFromJson = datajson;
      });
    }
  }

  void loadFile() {
    List listProduitFromJson = [];
    ListView.builder(
        itemCount: 25,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.black12,
            child: ListTile(
              title: Text(listProduitFromJson[index]['nom_article']),
              subtitle: Text(listProduitFromJson[index]['description']),
            ),
          );
        });
  }
  /* void appelapi(){
       Future<dynamic> getjsondata(var url) async{
         var uri=Uri.parse(url);
         http.Response response=await http.get(uri);
         if(response.statusCode== 200)
         return jsonDecode(response.body);
         else
         print("Erreur appel Reseau !!");
       }
     }*/
}
