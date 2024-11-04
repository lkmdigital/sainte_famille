import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';
import 'controllers/c_user.dart';
import 'views/Services/echec.dart';
import 'views/Services/success.dart';
import 'views/first_page.dart';
import 'views/login/login.dart';
import 'widgets/event_pref.dart';
import 'widgets/root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  StreamSubscription? sub;

  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  final darkThemeStr = await rootBundle.loadString('assets/darktheme.json');
  final darkThemeJson = jsonDecode(darkThemeStr);
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;
  final CUser _cUser = Get.put(CUser());

  runApp(MyApp(
    theme: theme,
    darkTheme: darkTheme,
  ));

  // Request permission to receive notifications

  // Handle any incoming messages

  // initUniLinks();
  // sub = linkStream.listen((String? link) {
  //   handleLink(link);
  // }, onError: (Object err) {
  //   // Handle the error (e.g., show an error message)
  // });
}

// Future<void> initUniLinks() async {
//   try {
//     final initialLink = await getInitialLink();
//     handleLink(initialLink);
//   } on PlatformException {
//     // Handle the error (e.g., show an error message)
//   }
// }

void handleLink(String? link) {
  if (link != null) {
    if (link.contains('/payment-success.html') || link.contains('success')) {
      Get.to(() => const Success());
    } else if (link.contains('/payment-echec') || link.contains('error')) {
      Get.to(() => const Echec());
    }
  }
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData darkTheme;

  const MyApp({super.key, required this.theme, required this.darkTheme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      // darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: EventPref.getUser(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return const Login();
            // return const Accueil()
            // return const Root();
            return const FirstPage();

          }), 
    );
  }
}