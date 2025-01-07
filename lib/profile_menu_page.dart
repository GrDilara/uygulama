import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({super.key});

  @override
  _ProfileMenuPageState createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  int _posts = 0;
  bool _isFollowing = false;
  List<String> postList = [];

  String username = 'JohnDoe';
  String fullName = 'John Doe';
  String location = 'New York, USA';
  String email = 'johndoe@example.com';

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  void _addPost(String postContent) {
    setState(() {
      _posts++;
      postList.insert(0, postContent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    username: username,
                    fullName: fullName,
                    location: location,
                    email: email,
                    onProfileUpdated: (updatedUsername, updatedFullName,
                        updatedLocation, updatedEmail) {
                      setState(() {
                        username = updatedUsername;
                        fullName = updatedFullName;
                        location = updatedLocation;
                        email = updatedEmail;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_picture.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(username,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(fullName,
                      style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  Text(location,
                      style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  Text(email,
                      style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        const Text('Posts',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('$_posts')
                      ]),
                      const Column(children: [
                        Text('Followers',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('120')
                      ]),
                      const Column(children: [
                        Text('Following',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('200')
                      ]),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _toggleFollow,
                    child: Text(_isFollowing ? 'Unfollow' : 'Follow'),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 6.0,
                          percent: 0.75,
                          center: const Text("80%",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          progressColor: Colors.green,
                          backgroundColor: Colors.grey[300]!,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                        ),
                        const SizedBox(width: 10),
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 6.0,
                          percent: 0.60,
                          center: const Text("Dog",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          progressColor: Colors.orange,
                          backgroundColor: Colors.grey[300]!,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                        ),
                        const SizedBox(width: 10),
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 6.0,
                          percent: 0.50,
                          center: const Text("Cat",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          progressColor: Colors.blue,
                          backgroundColor: Colors.grey[300]!,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                        ),
                        const SizedBox(width: 10),
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 6.0,
                          percent: 0.30,
                          center: const Text("Bird",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          progressColor: Colors.yellow,
                          backgroundColor: Colors.grey[300]!,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                        ),
                        const SizedBox(width: 10),
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 6.0,
                          percent: 0.40,
                          center: const Text("Fish",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          progressColor: Colors.purple,
                          backgroundColor: Colors.grey[300]!,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addPost("New Post Content"),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final String username;
  final String fullName;
  final String location;
  final String email;
  final Function(String, String, String, String) onProfileUpdated;

  const SettingsPage({
    super.key,
    required this.username,
    required this.fullName,
    required this.location,
    required this.email,
    required this.onProfileUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.blue),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileSettingsPage(
                    username: username,
                    fullName: fullName,
                    location: location,
                    email: email,
                    onProfileUpdated: onProfileUpdated,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logged Out'),
                  content: const Text('You have been logged out successfully.'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}