import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:software_engineering/firebase_options.dart';
import 'package:software_engineering/pages/home/home_page.dart';
import 'package:software_engineering/pages/login/login_page.dart';
import 'package:software_engineering/pages/match/match_page.dart';
import 'package:software_engineering/pages/mercenary/mercenary_page.dart';
import 'package:software_engineering/pages/rank/rank_page.dart';
import 'package:software_engineering/pages/setting/setting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isNotEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage = 0;
  final pages = [
    const HomePage(),
    const MercenaryPage(),
    const MatchPage(),
    const RankPage(),
    SettingPage()
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.emailVerified) {
          return Scaffold(
            body: pages.elementAt(selectedPage),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    selectedPage = value;
                  });
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people), label: '용병'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sports_soccer), label: '매치'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.emoji_events), label: '랭킹'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: '설정'),
                ]),
          );
        } else {
          return LogInPage();
        }
      },
    ));
  }
}
