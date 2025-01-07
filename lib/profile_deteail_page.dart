import 'package:flutter/material.dart';


class ProfileEditPage extends StatelessWidget {
  final String username;
  final String fullName;
  final String location;
  final String email;
  final Function(String, String, String, String) onProfileUpdated;

  const ProfileEditPage({super.key, 
    required this.username,
    required this.fullName,
    required this.location,
    required this.email,
    required this.onProfileUpdated,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController(text: username);
    TextEditingController fullNameController = TextEditingController(text: fullName);
    TextEditingController locationController = TextEditingController(text: location);
    TextEditingController emailController = TextEditingController(text: email);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onProfileUpdated(
                  usernameController.text,
                  fullNameController.text,
                  locationController.text,
                  emailController.text,
                );
                Navigator.pop(context); // Go back to the settings page
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
