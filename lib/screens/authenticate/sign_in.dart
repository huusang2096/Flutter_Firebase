import 'package:flutter/material.dart';
import 'package:flutter_app_chat/components/custom_surffix_icon.dart';
import 'package:flutter_app_chat/components/form_error.dart';
import 'package:flutter_app_chat/components/size_config.dart';
import 'package:flutter_app_chat/screens/authenticate/register.dart';
import 'package:flutter_app_chat/screens/home/home.dart';
import 'package:flutter_app_chat/screens/services/auth.dart';
import 'package:flutter_app_chat/shared/loading.dart';

class SignIn extends StatefulWidget {
  static String routeName = "/sign_in";
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  String email="",password="";
  final _formKey = GlobalKey<FormState>();
  final List<String> errors =[];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
        backgroundColor: Colors.orange[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              Navigator.of(context).pushNamed(Register.routeName);
            },
            icon: Icon(Icons.person),
            label: Text("Register"),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                buildEmailFormField(),
                SizedBox(height: 20,),
                buildPasswordFormField(),
                SizedBox(height: 20,),
                FormError(errors: errors,),
                SizedBox(height: 20,),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async{
                        dynamic result = await _authService.signInAnon();
                        if(result == null){
                          print("error signing in");
                        }else{
                          print("Sign in with Anonymous");
                          print(result.uid);
                        }
                      },
                      child: Text("Sign in Anonymous"),
                    ),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text("Sign In",style: TextStyle(
                        color: Colors.white
                      ),),
                      onPressed: () async{
                        if(_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          try {
                            dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                            if (result != null) {
                              setState(() {
                                loading = false;
                              });
                              Navigator.of(context).pushNamedAndRemoveUntil(Home.routeName, (route) => false);
                            }
                          }catch(e){
                            setState(() {
                              loading = false;
                            });
                            print("==> ERROR: " + e.toString());
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon:CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (val)=> password=val,
      validator: (value) {
        if(value.length < 6){
          addError(error: "Password is too short!");
          return"";
        }
        if(value.isEmpty){
          addError(error: "Enter password 6\+ characters");
          return "";
        }
        return null;
      } ,
      obscureText: true,
      onChanged: (value){
        if(value.length >= 6){
          removeError(error: "Password is too short!");
        }
        if(value.isNotEmpty){
          removeError(error: "Enter password 6\+ characters");
        }
        return password = value;
      },
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        suffixIcon:CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (val) => email = val,
      validator: (value) {
        if(value.isEmpty){
          addError(error:"Enter an Email");
          return"";
        }
        if(!SizeConfig.emailValidatorRegExp.hasMatch(value)){
          addError(error: "Email invalid. ex:'appcore@abc.abc'");
          return"";
        }
        return null;
      },
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error:"Enter an Email");
        }
        if(SizeConfig.emailValidatorRegExp.hasMatch(value)){
          removeError(error: "Email invalid. ex:'appcore@abc.abc'");
        }
        return email = value;
      },
    );
  }

  void addError({String error}){
    if(!errors.contains(error)){
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}){
    if(errors.contains(error)){
      setState(() {
        errors.remove(error);
      });
    }
  }

}

