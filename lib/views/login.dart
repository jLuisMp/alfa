import 'package:alfa/api/database.dart';
import 'package:alfa/api/preference.dart';
import 'package:alfa/views/list.dart';
import 'package:alfa/views/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  DataBase handler;
  Login({this.handler});
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController emailController;
  TextEditingController passController;
  Preferences preferences=Preferences();
  double sizeW, sizeH;

  void initState(){
    super.initState();
    emailController=TextEditingController();
    passController=TextEditingController();
  }
  void showError(String title,body){
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

  Widget botonIniciar(String label,int type) {
    return GestureDetector(
      child: Container(
          width: sizeW * 0.5,
          height: 50,
          margin: const EdgeInsets.only(top: 15),
          child: Center(
            child: Text(
              label,
            ),
          )),
      onTap: () async {
        if(type==1){
        await widget.handler.searchUser(emailController.text).then((value){
          if(value==null){
            showError("Email no registrado", "El email ${emailController.text} no se ha registrado");
          }else{
            if(value.password==passController.text){
              preferences.logged=true;
              preferences.commit();
            Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ListUser(title: "Alfa-Jose Luis", handler: widget.handler)),
      ModalRoute.withName('/'));
            }else{
              showError("Contraseña no valida","La contraseña y el email no coinciden");
            }
          }
        });
        }else{
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Register(handler: widget.handler)));
        }
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
            botonIniciar("Iniciar",1),
            botonIniciar("Crear cuenta",2),
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
