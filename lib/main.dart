import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/screens/checkout.dart';
import 'package:shoppy/screens/home.dart';
import 'package:shoppy/screens/login.dart';
import 'package:shoppy/screens/profile.dart';
import 'package:shoppy/utils/application_state.dart';
import 'package:shoppy/utils/custom_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final String response =
      await rootBundle.loadString("assets/config/stripe.json");
  final data = await json.decode(response);
  Stripe.publishableKey = data["publishableKey"];

  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => Consumer<ApplicationState>(
            builder: ((context, applicationState, child) {
              Widget child;
              switch (applicationState.loginState) {
                case ApplicationLoginState.loggedOut:
                  child = const LoginScreen();
                  break;
                case ApplicationLoginState.loggedIn:
                  child = const MyApp();
                  break;
                default:
                  child = const LoginScreen();
              }

              return MaterialApp(
                theme: CustomTheme.getTheme(),
                home: child,
              );
            }),
          )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: CustomTheme.getTheme(),
        home: DefaultTabController(
            length: 3,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("SHOPPY"),
                ),
                bottomNavigationBar: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                    boxShadow: CustomTheme.cardShadow,
                  ),
                  child: const TabBar(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(icon: Icon(Icons.home)),
                        Tab(icon: Icon(Icons.person)),
                        Tab(icon: Icon(Icons.shopping_cart))
                      ]),
                ),
                body: const TabBarView(children: [
                  HomeScreen(),
                  ProfileScreen(),
                  CheckoutScreen()
                ]),
              ),
            )));
  }
}
