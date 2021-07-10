import 'package:alfa/api/database.dart';
import 'package:alfa/models/user.dart';
import 'package:alfa/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListUser extends StatefulWidget{
  late String title;
  late DataBase handler;
  ListUser({required this.title,required this.handler});
  ListUserState createState()=> ListUserState();
}
class ListUserState extends State<ListUser>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            child:Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(Icons.exit_to_app,size: 30,),
            ),
            onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Login(handler: widget.handler))),
          )
        ],
      ),
      body: FutureBuilder(
        future: widget.handler.retrieveUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data![index].id!),
                  onDismissed: (DismissDirection direction) async {
                    await widget.handler.deleteUser(snapshot.data![index].id!);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                      child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].city.toString()+","+snapshot.data![index].country.toString()),
                  )),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  
}