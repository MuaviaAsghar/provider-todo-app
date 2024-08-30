import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/Screens/active_page.dart';
import 'package:riverpod_todo/Screens/home_page.dart';

import 'Screens/completed_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Defaulthome(),
    );
  }
}

class Defaulthome extends StatelessWidget {
  const Defaulthome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const HomePage(),
      const ActivePage(),
      const CompletedPage()
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(
                  icon: Icon(Icons.lightbulb),
                  text: 'Active Tasks',
                ),
                Tab(icon: Icon(Icons.fact_check), text: 'Completed'),
              ],
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(2.0),
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}
