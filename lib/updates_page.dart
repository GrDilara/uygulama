import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  _UpdatesPageState createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Mock list of notifications with type
  List<Map<String, String>> notifications = [
    {
      'type': 'message',
      'title': 'Pamuku sahiplenmek istiyorum',
      'message': 'Profilinizden şartlarınıza baktım. İstanbul\'da yaşıyormuşsunuz bir yüz yüze görüşelim size de uygun olursa',
    },
    {
      'type': 'message',
      'title': 'Yeni bir mesaj aldınız!',
      'message': 'Bir kullanıcı size mesaj gönderdi.',
    },
    {
      'type': 'follow',
      'title': 'Yeni takipçi',
      'message': 'Olivia sizi takip etmeye başladı.',
    },
    {
      'type': 'like',
      'title': 'Beğenildi',
      'message': 'Fatma paylaşımınızı beğendi.',
    }
  ];

  @override
  void initState() {
    super.initState();

    // Initialize local notifications
    _initializeNotifications();
  }

  // Initialize local notifications
  Future<void> _initializeNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: _onSelectNotification);
  }

  // Handle notification tap
  Future<void> _onSelectNotification(NotificationResponse? notificationResponse) async {
    if (notificationResponse != null && notificationResponse.payload != null) {
      if (notificationResponse.payload == 'Follow notification') {
        _navigateToChatPage();
      }
    }
  }

  // Navigate to notification detail page
  void _navigateToNotificationDetailPage(String title, String message, {String? user}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationDetailPage(title: title, message: message, user: user)),
    );
  }

  // Navigate to chat page
  void _navigateToChatPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final type = notification['type'] ?? 'unknown'; // Provide a default value
          final title = notification['title'] ?? 'No Title'; // Provide a default value

          return ListTile(
            leading: _buildLeadingIcon(type),
            title: Text(title),
            onTap: () {
              final message = notification['message'] ?? 'No Message'; // Provide a default value
              final user = notification['user']; // Provide user if available
              if (type == 'message') {
                _navigateToNotificationDetailPage(title, message);
              } else if (type == 'follow') {
                _navigateToNotificationDetailPage(title, message, user: user);
              } else if (type == 'like') {
                _navigateToNotificationDetailPage(title, message, user: user);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildLeadingIcon(String type) {
    switch (type) {
      case 'message':
        return const Icon(Icons.message);
      case 'follow':
        return const Icon(Icons.person_add);
      case 'like':
        return const Icon(Icons.thumb_up);
      default:
        return const Icon(Icons.notifications);
    }
  }
}

class NotificationDetailPage extends StatelessWidget {
  final String title;
  final String message;
  final String? user;

  const NotificationDetailPage({super.key, required this.title, required this.message, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 18),
            ),
            if (user != null) ...[
              const SizedBox(height: 16),
              Text(
                'Kullanıcı: $user',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              child: const Text('Sohbete Git'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sohbet Sayfası'),
      ),
      body: const Center(
        child: Text(''), // "Sohbet sayfasına hoş geldiniz!" metnini kaldırdık
      ),
    );
  }
}
