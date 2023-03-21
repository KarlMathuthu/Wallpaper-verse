import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_verse/firebase_options.dart';
import 'package:wallpaper_verse/main_home.dart';
import 'package:wallpaper_verse/theme/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => ThemeModel()),
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            theme: themeNotifier.isDark
                ? ThemeData(
                    useMaterial3: true,
                    brightness: Brightness.dark,
                    fontFamily: 'Poppins',
                  )
                : ThemeData(
                    useMaterial3: true,
                    fontFamily: 'Poppins',
                    brightness: Brightness.light,
                  ),
            debugShowCheckedModeBanner: false,
            home: const MainHome(),
          );
        },
      ),
    );
  }
}
