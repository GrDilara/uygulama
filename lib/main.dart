import 'package:flutter/material.dart';
import 'profile_menu_page.dart';
import 'blog_page.dart';
import 'updates_page.dart';
import 'login_page.dart'; 
import 'signup_page.dart';
import 'main_feed_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation UI',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),  // Ana sayfa HomePage kullanılarak yönlendirme sağlandı
        '/blog': (context) => BlogPage(),
        '/updates': (context) => UpdatesPage(),
        '/profile': (context) => ProfileMenuPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Navigator(
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => MainFeedPage (),
            ),
          ),
          Navigator(
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => BlogPage(),
            ),
          ),
          Navigator(
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => UpdatesPage(),
            ),
          ),
          Navigator(
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => ProfileMenuPage(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {  // Burada setState() doğru şekilde çağrılıyor
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.purple,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.purple.withOpacity(0.5)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets, color: Colors.purple.withOpacity(0.5)),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,
                color: Colors.purple.withOpacity(0.5)),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.purple.withOpacity(0.5)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
