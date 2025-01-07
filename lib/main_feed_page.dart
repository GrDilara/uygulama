import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class MainFeedPage extends StatelessWidget {
  final List<SwipeItem> swipeItems = [
    SwipeItem(
      content: const PostCard(
        title: "Golden Retriever Yavruları",
        description: "Sevgi dolu bir yuva arıyorlar!",
        imageUrl: 'assets/post2.jpg',
      ),
    ),
    SwipeItem(
      content: const PostCard(
        title: "Kayıp Kedi",
        description: "Beyaz kedi, 2 yaşında, İzmir civarında kayboldu.",
        imageUrl: 'assets/post1.jpg',
      ),
    ),
  ];

  final MatchEngine matchEngine;

  MainFeedPage({super.key})
      : matchEngine = MatchEngine(swipeItems: [
          SwipeItem(
            content: const PostCard(
              title: "Golden Retriever Yavruları",
              description: "Sevgi dolu bir yuva arıyorlar!",
              imageUrl: 'assets/post2.jpg',
            ),
          ),
          SwipeItem(
            content: const PostCard(
              title: "Sahiplendirme İlanı",
              description: "Yavru kediler sahiplendirilecektir.",
              imageUrl: 'assets/post3.jpg',
            ),
          ),
        ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Akış'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.purple),
                  hintText: "Arama yap",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            _sectionTitle("Yuva Arıyanlar"),
            SizedBox(
              height: 400,
              child: SwipeCards(
                matchEngine: matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return swipeItems[index].content;
                },
                onStackFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Daha fazla ilan yok!")),
                  );
                },
                itemChanged: (SwipeItem item, int index) {
                  print("Değişen ilan: $index");
                },
              ),
            ),
            _sectionTitle("Barınaklar"),
            _horizontalListView([
              const HorizontalCard(
                title: "Yıldırım Belediyesi Hayvan Barınağı",
                distance: "1 km",
                imageUrl: 'assets/shelter1.jpg',
              ),
              const HorizontalCard(
                title: "Nilüfer Belediyesi Hayvan Barınağı",
                distance: "5 km",
                imageUrl: 'assets/shelter2.jpg',
              ),
              const HorizontalCard(
                title: "Osmangazi Hayvan Barınağı",
                distance: "8 km",
                imageUrl: 'assets/shelter3.jpg',
              ),
            ]),
            _sectionTitle("Veteriner Klinikleri"),
            _horizontalListView([
              const HorizontalCard(
                title: "Pati Veteriner Kliniği",
                distance: "2 km",
                imageUrl: 'assets/clinic1.jpg',
              ),
              const HorizontalCard(
                title: "Sevimli Dostlar Kliniği",
                distance: "7 km",
                imageUrl: 'assets/clinic2.jpg',
              ),
              const HorizontalCard(
                title: "Dost Pati Kliniği",
                distance: "12 km",
                imageUrl: 'assets/clinic3.jpg',
              ),
            ]),
            _sectionTitle("Kayıp İlanları"),
            _horizontalListView([
              const PostCard(
                title: "Kaybolan Kedi",
                description: "Kayıp ilanı: Beyaz renkli kedi, 3 gün önce kayboldu.",
                imageUrl: 'assets/post1.jpg',
              ),
              const PostCard(
                title: "Acil Yardım",
                description: "Yaralı köpek için acil veteriner aranıyor.",
                imageUrl: 'assets/post3.jpg',
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _horizontalListView(List<Widget> cards) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cards,
      ),
    );
  }
}


class HorizontalCard extends StatelessWidget {
  final String title;
  final String distance;
  final String imageUrl;

  const HorizontalCard({
    super.key,
    required this.title,
    required this.distance,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageUrl,
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text("Mesafe: $distance"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const PostCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
