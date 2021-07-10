import 'package:alfa/api/database.dart';
import 'package:alfa/models/user.dart';
import 'package:alfa/views/list.dart';
import 'package:alfa/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jose Luis Moyotl',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Alfa-Jose Luis'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late DataBase handler;

  @override
  void initState() {
    super.initState();
    this.handler = DataBase();
    this.handler.initializeDB().whenComplete(() async {
      await this.addUsers();
      setState(() {});
    });
  }
  Future<int> addUsers() async {
    User firstUser = User(name: "peter", city: "Puebla", country: "Lebanon", gender: "Masculino",email: "luismoyotl.p@gmail.com");
    User secondUser = User(name: "john", city: "Tlaxcala", country: "United Kingdom",gender: "Masculino",email: "luismoyotl1b@gmail.com");
    List<User> listOfUsers = [firstUser, secondUser];
    return await handler.insertUser(listOfUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Login(handler:handler);
  }
}