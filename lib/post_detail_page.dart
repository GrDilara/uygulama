import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Detail App',
      home: PostDetailPage(
        postContent: 'This is a post about a cute cat.',
        postTitle: 'Cute Cat Post',
        postImage: 'assets/default_image.png',
      ),
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final String postContent;
  final String? postTitle;
  final String? postImage;

  const PostDetailPage({super.key, 
    required this.postContent,
    this.postTitle = "Default Title",
    this.postImage = "assets/default_image.png",
  });

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late String postContent;
  late String postTitle;
  late String postImage;

  @override
  void initState() {
    super.initState();
    postContent = widget.postContent;
    postTitle = widget.postTitle!;
    postImage = widget.postImage!;
  }

  String determineAnimalCategory(String content) {
    if (content.contains("cat")) {
      return "Cat";
    } else if (content.contains("dog")) {
      return "Dog";
    } else {
      return "Other";
    }
  }

  @override
  Widget build(BuildContext context) {
    final String category = determineAnimalCategory(postContent);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    // Resim üzerine tıklanınca geniş görüntüleme
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Stack(
                            children: [
                              Image.asset(
                                postImage,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditImagePage(
                                          initialTitle: postTitle,
                                          initialContent: postContent,
                                          initialImage: postImage,
                                        ),
                                      ),
                                    ).then((result) {
                                      if (result != null) {
                                        setState(() {
                                          postTitle = result['title'];
                                          postContent = result['content'];
                                          postImage = result['image'];
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    postImage,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              postTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              postContent,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Animal Category"),
                      content: Text("This post is related to: $category"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Show Animal Category'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPostPage(
                      initialTitle: postTitle,
                      initialContent: postContent,
                    ),
                  ),
                ).then((result) {
                  if (result != null) {
                    setState(() {
                      postTitle = result['title'];
                      postContent = result['content'];
                    });
                  }
                });
              },
              child: const Text('Edit Post'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditImagePage extends StatefulWidget {
  final String initialTitle;
  final String initialContent;
  final String initialImage;

  const EditImagePage({super.key, 
    required this.initialTitle,
    required this.initialContent,
    required this.initialImage,
  });

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);
    _imageController = TextEditingController(text: widget.initialImage);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Image Details'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Post Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Post Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image Path'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'title': _titleController.text,
                  'content': _contentController.text,
                  'image': _imageController.text,
                });
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPostPage extends StatefulWidget {
  final String initialTitle;
  final String initialContent;

  const EditPostPage({super.key, required this.initialTitle, required this.initialContent});

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Post Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Post Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'title': _titleController.text,
                  'content': _contentController.text,
                });
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
