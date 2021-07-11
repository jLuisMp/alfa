import 'package:alfa/api/database.dart';
import 'package:alfa/api/preference.dart';
import 'package:alfa/models/user.dart';
import 'package:alfa/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListUser extends StatefulWidget{
  String title;
  DataBase handler;
  ListUser({this.title,this.handler});
  ListUserState createState()=> ListUserState();
}
class ListUserState extends State<ListUser>{
  TextEditingController searchController;
  Preferences preferences = Preferences();
  String textSearch;
  bool search;
  void initState(){
    super.initState();
    searchController= TextEditingController();
    textSearch="";
    search=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          !search?GestureDetector(
          child:Icon(Icons.search,size:30),
          onTap: (){
            setState(() {
              search=!(search);
            });
          },
          ):
          Container(
            width: MediaQuery.of(context).size.width*.30,
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  textSearch=value;
                });
              },
            ),
          ),
          GestureDetector(
            child:Container(
              margin: const EdgeInsets.only(right: 10,left: 10),
              child: Icon(Icons.exit_to_app,size: 30,),
            ),
            onTap: (){
              preferences.logged=false;
              preferences.commit();
              Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login( handler: widget.handler)),
      ModalRoute.withName('/'));
      }
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
                if(searchController.text==""||searchController.text==null){
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data[index].id),
                  onDismissed: (DismissDirection direction) async {
                    await widget.handler.deleteUser(snapshot.data[index].id);
                    setState(() {
                      snapshot.data.remove(snapshot.data[index]);
                    });
                  },
                  child: Card(
                      child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].city.toString()+","+snapshot.data[index].country.toString()),
                  )),
                );
              }else{
                if(snapshot.data[index].name.indexOf(textSearch)!=-1||snapshot.data[index].country.indexOf(textSearch)!=-1||snapshot.data[index].city.indexOf(textSearch)!=-1||snapshot.data[index].gender.indexOf(textSearch)!=-1){
                  return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data[index].id),
                  onDismissed: (DismissDirection direction) async {
                    await widget.handler.deleteUser(snapshot.data[index].id);
                    setState(() {
                      snapshot.data.remove(snapshot.data[index]);
                    });
                  },
                  child: Card(
                      child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].city.toString()+","+snapshot.data[index].country.toString()),
                  )),
                );
                }else{
                  return Container();
                }
              }
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