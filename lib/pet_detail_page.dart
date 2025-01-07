import 'package:flutter/material.dart';
import 'login_page.dart';

class PetDetailPage extends StatefulWidget {
  const PetDetailPage({super.key});

  @override
  _PetDetailPageState createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  bool isLoggedIn = false; // Kullanıcı giriş durumu

  @override
  void initState() {
    super.initState();
    // Giriş durumu kontrolü (örnek olarak false başlatılıyor)
    checkLoginStatus();
  }

  // Örnek login durumu kontrolü
  void checkLoginStatus() {
    // Burada giriş durumu kontrol edilebilir (örneğin shared preferences veya backend kullanarak)
    setState(() {
      isLoggedIn = false; // Giriş yapılmamış durumda
    });
  }

  @override
  Widget build(BuildContext context) {
    // Eğer kullanıcı giriş yapmamışsa LoginPage'e yönlendir
    if (!isLoggedIn) {
      return const LoginRedirectWidget();
    }

    // Kullanıcı giriş yapmışsa PetDetailPage gösterilir
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("Gary"),
      ),
      body: Column(
        children: [
          Image.network('https://placekitten.com/400/300'),
          const SizedBox(height: 16),
          const ListTile(
            title: Text("Gary"),
            subtitle: Text("1 year - Golden - 20 kg"),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since.",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Kullanıcının beğenme veya bağış yapma işlemi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("You liked Gary!")),
              );
            },
            child: const Text("Like Gary"),
          ),
        ],
      ),
    );
  }
}

// Giriş yapılmamışsa LoginPage'e yönlendirme widget'ı
class LoginRedirectWidget extends StatelessWidget {
  const LoginRedirectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 80, color: Colors.purple),
            const SizedBox(height: 20),
            const Text(
              "You need to login to see this page.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Login sayfasına yönlendir
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text("Go to Login Page"),
            ),
          ],
        ),
      ),
    );
  }
}
