import 'package:brew_crew/models/restaurant.dart';
import 'package:brew_crew/models/shop.dart';
import 'package:brew_crew/screens/home/cart_page.dart';
import 'package:brew_crew/screens/home/settings.dart';
import 'package:brew_crew/screens/home/shop_page.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/theme/theme_provider.dart';
import 'package:flutter/material.dart';
// import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      // const MyApp()
    MultiProvider(
        providers: [
     ChangeNotifierProvider( create: (context) => Shop()),

     ChangeNotifierProvider( create: (context) => ThemeProvider()),

     ChangeNotifierProvider(create: (context) => Restaurant()),

      ],
      child: const MyApp(),

    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserApp?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        theme: Provider.of<ThemeProvider>(context).themeData,
        routes: {
          '/wrapper': (context) => const Wrapper(),
          '/shop_page': (context) => const ShopPage(),
          '/cart_page': (context) => const CartPage(),
          '/settings': (context) => const Settings(),

        },
      
      ),
    );
  }
}

