import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sportsappflutter/newstile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future getData() async {
    final apiUrl = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=gb&category=sports&apiKey=bb66e3f0405944a58cb6853e55995bec');
    final response = await http.get(apiUrl);
    var data = response.body;
    return jsonDecode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data['articles'].length,
                itemBuilder: (context, index) {
                  return NewsTile(
                    imgUrl:
                        snapshot.data['articles'][index]['urlToImage'] ?? "",
                    title: snapshot.data['articles'][index]['title'] ?? "",
                    desc: snapshot.data['articles'][index]['description'] ?? "",
                    content: snapshot.data['articles'][index]['content'] ?? "",
                    posturl: snapshot.data['articles'][index]['url'] ?? "",
                  );
                });
          }
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue, size: 100),
          );
        },
      ),
    );
  }
}
