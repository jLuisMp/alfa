import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static const LOGGED = "logged";

  static final Preferences instance = Preferences._internal();


  //Campos a manejar
  SharedPreferences _sharedPreferences;
  bool logged = false;

  Preferences._internal();

  factory Preferences()=>instance;

  Future<SharedPreferences> get preferences async{
    if(_sharedPreferences != null){
      return _sharedPreferences;
    }else{
      _sharedPreferences = await SharedPreferences.getInstance(); 
      logged = _sharedPreferences.getBool(LOGGED)??false; 

      if(logged == null)
        logged = false;


      return _sharedPreferences;

    }

  }
  Future<void> commit() async {
    await _sharedPreferences.setBool(LOGGED, logged);
  }

  Future<Preferences> init() async{
    _sharedPreferences = await preferences;
    return this;
  }

}