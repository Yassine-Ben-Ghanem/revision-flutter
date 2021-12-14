import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet2/Model/Article.dart';
import 'package:projet2/db/DataBaseHelper.dart';

class MyListArticle extends StatelessWidget {
  DataBaseHelper db = new DataBaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: FutureBuilder<List<Article>>(
          future: DataBaseHelper.instance.getArticles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> Snapshot) {
            if (!Snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView(
              children: Snapshot.data!.map((art) {
                return Card(
                  child: ListTile(
                    title: Text(art.lib),
                    subtitle: Text(art.qte.toString()),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
/*
Widget CardDesign(String title, String subtitle) {
  return Card(
    color: Colors.blue[200],
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    ),
  );
  
}*/
