// ignore_for_file: unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Connexion';

  @override
  Widget build(BuildContext context) {
    var entries = const [
      {'nomarticle': '1', 'description': 'clavier usb avec 102 Touche'},
      {'nomarticle': '2', 'description': 'souris usb avec lumiere rouge'},
      {'nomarticle': '3', 'description': 'ecron usb avec vision hd'}
    ];
    final List<int> colorCodes = <int>[100, 100, 100];
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        drawer: Drawer(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    tileColor: Colors.amber[colorCodes[index]],
                    title: Text('Article ${entries[index]['nomarticle']}'),
                    subtitle: Text('${entries[index]['description']}'),
                  ),
                );
              }),
          /*child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    tileColor: Colors.amber[colorCodes[index]],
                    title: Text('Article ${entries[index]['nomarticle']}'),
                    subtitle: Text('${entries[index]['description']}'),
                  ),
                );
              }),*/
          /*child: ListView(
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
            children: [
              Card(
                child: ListTile(
                    tileColor: Colors.amber[600],
                    trailing: Icon(Icons.add),
                    title: const Text('Article 1'),
                    subtitle: const Text('description article 1'),
                    onTap: () {
                      Navigator.pushNamed(context, "/ajout");
                    }),
              ),
              Divider(),
              Card(
                child: ListTile(
                  trailing: Icon(Icons.add),
                  title: const Text('Article 2'),
                  subtitle: const Text('description article 2'),
                  onTap: () {
                    Navigator.pushNamed(context, "/colors");
                  },
                ),
              ),
              Divider(),
              Card(
                child: ListTile(
                  trailing: Icon(Icons.add),
                  title: const Text('Article 2'),
                  subtitle: const Text('description article 2'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),*/
        ),
        body: SingleChildScrollView(
          child: const MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

enum Rad { Option1, Option2, Option3 }

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  String err = "";

  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  Rad? _character = Rad.Option1;
  @override
  Widget build(BuildContext context) {
    loadArticleList();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          spacer(),
          widgetLogin(),
          spacer(),
          widgetPassword(),
          Text(err),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: const Text('Submit'),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                  child: const Text('Cancel'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void loadArticleList() {
    List listProduitFromJson = [];
    Future<String?> loadFile() async {
      String contenu = await rootBundle.loadString('data/list_articles.json');
      print(contenu);
      List datajson = jsonDecode(contenu);
      setState(() {
        listProduitFromJson = datajson;
      });
    }
  }

  String? loadFile() {
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

  Widget spacer() {
    return Padding(padding: EdgeInsets.only(top: 30.0));
  }

  Widget widgetLogin() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Login",
        hintText: 'Login',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Entrez login!';
        } else if (value.length > 15) {
          return 'Your text is too long !';
        }
        return null;
      },
    );
  }

  Widget widgetPassword() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: '*******',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password !';
        } else if (value.length > 15) {
          return 'Your password is too long !';
        } else if (value.length < 6) {
          return 'your password is too short !';
        }
        return null;
      },
      obscureText: true,
      controller: pass,
    );
  }
}
