import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  //bool _isFavorite = false;
  final List<bool> _blogFavorites = [true, true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Blog yazısı ara",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Popular Blogs",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildPopularBlogs(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Recently Added Blogs",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildRecentlyAddedBlogs(),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularBlogs() {
    return Column(
      children: [
        _buildBlogCard(
          index: 0,
          imageUrl: "https://via.placeholder.com/150",
          title: "Hayvan Sahiplenme",
          isFavorite: _blogFavorites[0],
        ),
        _buildBlogCard(
          index: 1,
          imageUrl: "https://via.placeholder.com/150",
          title: "Hayvan Sahiplenme",
          isFavorite: _blogFavorites[1],
        ),
      ],
    );
  }

  Widget _buildRecentlyAddedBlogs() {
    return Column(
      children: [
        _buildBlogCard(
          index: 2,
          imageUrl: "https://via.placeholder.com/150",
          title: "Hayvan Sahiplenirken Dikkat Edilmesi Gerekenler",
          isFavorite: _blogFavorites[2],
        ),
        _buildBlogCard(
          index: 3,
          imageUrl: "https://via.placeholder.com/150",
          title: "Hayvan Sahiplenirken Dikkat Edilmesi Gerekenler",
          isFavorite: _blogFavorites[3],
        ),
      ],
    );
  }

  Widget _buildBlogCard({required int index, required String imageUrl, required String title, required bool isFavorite}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetailPage(
                imageUrl: imageUrl,
                title: title,
                isFavorite: isFavorite,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.purple,
                    ),
                    onPressed: () {
                      setState(() {
                        _blogFavorites[index] = !_blogFavorites[index];
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogDetailPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final bool isFavorite;

  const BlogDetailPage({super.key, required this.imageUrl, required this.title, required this.isFavorite});

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.purple,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BlogPage(),
  ));
}
