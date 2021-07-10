import 'package:alfa/api/database.dart';
import 'package:alfa/views/list.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  late DataBase handler;
  Login({required this.handler});
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passController;
  late double sizeW, sizeH;

  void initState(){
    super.initState();
    emailController=TextEditingController();
    passController=TextEditingController();
  }
  void shoeError(String title,body){
    showDialog(
      context: context, 
      builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title,textAlign: TextAlign.center,),
              content:Text(body,textAlign: TextAlign.center,),
              actions: <Widget>[
                TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
              ],
            );
                  },
      );
  }

  Widget logField(TextEditingController controllerText,
      String textHint, bool isPass) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child:  Container(
            margin: const EdgeInsets.only(left: 5),
            padding: const EdgeInsets.only(left: 15),
            width: sizeW * 0.75,
            height: 50,
            child: TextField(
              controller: controllerText,
              obscureText: isPass,
              decoration: InputDecoration(
                  hintText: textHint,
                  border: InputBorder.none),
            ),
          )
    );
  }

  Widget botonIniciar() {
    return GestureDetector(
      child: Container(
          width: sizeW * 0.5,
          height: 50,
          margin: const EdgeInsets.only(top: 15),
          child: Center(
            child: Text(
              "Iniciar sesión",
            ),
          )),
      onTap: () async {
        await widget.handler.searchUser(emailController.text).then((value){
          if(value==null){
            shoeError("Email no registrado", "El email ${emailController.text} no se ha registrado");
          }else{
            print("Bienvenido "+ value.name);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ListUser(title: "Alfa-Jose Luis", handler: widget.handler)));
          }
        });
      },
    );
  }


  Widget menu() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logField(emailController,
                "Email", false),
            logField(passController, "Contraseña", true),
            botonIniciar(),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    sizeW = MediaQuery.of(context).size.width;
    sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: menu(),
      ),
      /*Stack(
        children: [FondoLog(), menu()],
      ),*/
    );
  }
}
