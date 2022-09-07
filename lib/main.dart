import 'package:flutter/material.dart';
import 'package:movie_app/network/dataagents/http_movie_data_agent_impl.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/pages/movie_details_page.dart';

import 'network/dataagents/dio_movie_data_Agent_impl.dart';
import 'network/dataagents/retrofit_data_agent_impl.dart';


void main() {
  RetrofitDataAgentImpl().getActors(1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}

