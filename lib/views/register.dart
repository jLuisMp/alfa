import 'package:alfa/api/database.dart';
import 'package:alfa/models/user.dart';
import 'package:alfa/views/list.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  DataBase handler;
  Register({this.handler});
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  TextEditingController genderController;
  TextEditingController cityController;
  TextEditingController countryController;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passController;
  double sizeW, sizeH;

  void initState(){
    super.initState();
    genderController=TextEditingController();
    cityController=TextEditingController();
    countryController=TextEditingController();
    nameController=TextEditingController();
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
                child: Text("Aceptar"),
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
              "Iniciar",
            ),
          )),
      onTap: () async {
        if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)){
          if(RegExp(r"^(?=(?:.*[A-Z]){1})(?=(?:.*[a-z]){1})\S{8,}$").hasMatch(passController.text)){
            await widget.handler.insertUser([User(name: nameController.text, city: cityController.text, country:countryController.text, gender: genderController.text,email: emailController.text,password: passController.text)]);
            Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ListUser(title: "Alfa-Jose Luis", handler: widget.handler)),
      ModalRoute.withName('/'));
          }
          else {
            showError("Formato de contraseña", "Debe tener al menos una mayúscula,una minúscula y 8 caracteres");
          }
        }else{
          showError("Email no valido", "ingresa un email valido");
        }
      },
    );
  }


  Widget menu() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logField(nameController, "Nombre", false),
            logField(cityController,"Ciudad", false),
            logField(countryController,"Pais", false),
            logField(genderController,"Genero", false),
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
      appBar: AppBar(title: Text("Registro"),),
      body: Center(
        child: menu(),
      ),
      /*Stack(
        children: [FondoLog(), menu()],
      ),*/
    );
  }
}
