import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/components/custom_button.dart';
import 'package:shoppy/components/custom_text_input.dart';
import 'package:shoppy/utils/application_state.dart';
import 'package:shoppy/utils/custom_theme.dart';
import 'package:shoppy/utils/login_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loadingbutton = false;
  Map<String, String> data = {};

  _LoginScreenState() {
    data = LoginData.signIn;
  }
  
  void switchLogin() {
    setState(() {
      if (mapEquals(data, LoginData.signUp)) {
        data = LoginData.signIn;
      } else {
        data = LoginData.signUp;
      }
    });
  }
loginError(FirebaseAuthException e ){
  if(e.message!=""){
    setState(() {
      _loadingbutton=false;
    });
  }
}

  void loginButtonPressed() {
    setState(() {
      _loadingbutton=true;
    });
    ApplicationState applicationState = Provider.of<ApplicationState>(context, listen: false);
    if (mapEquals(data, LoginData.signUp)){
      applicationState.signIn(_emailController.text , _passwordController.text, loginError);
    }
    else{
            applicationState.signIn(_emailController.text , _passwordController.text, loginError);

    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 40.0, bottom: 40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      data["heading"] as String,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Text(
                    data["subHeading"] as String,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )),
          model(data, _emailController, _passwordController),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: switchLogin,
                  child: Text(
                    data["footer"] as String,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  model(Map<String, String> data, TextEditingController emailController,
    TextEditingController passworController) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 56),
    decoration: CustomTheme.getCardDecoration(),
    child: Column(
      children: [
        CustomTextInput(
            label: "Your email address",
            placeholder: "emal@address.com",
            icon: Icons.person_outline,
            textEditingController: _emailController),
        CustomTextInput(
            label: "password",
            placeholder: "password",
            icon: Icons.lock_outline,
            password: true,
            textEditingController: _passwordController),

        CustomButton(
          text: data["label"] as String, 
          onpress: loginButtonPressed,
          loading: _loadingbutton,)
      ],
    ),
  );
}
}
  


