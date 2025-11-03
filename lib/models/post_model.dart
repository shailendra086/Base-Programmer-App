class Post {
  final int id;
  final String title;
  final String excerpt; // short HTML
  final String content; // full HTML
  final String imageUrl;
  final List<String> tags;
  final String authorName;
  final String date;

  Post({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
    required this.tags,
    required this.authorName,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // ✅ Image
    String imageUrl = '';
    if (json['_embedded'] != null &&
        json['_embedded']['wp:featuredmedia'] != null &&
        (json['_embedded']['wp:featuredmedia'] as List).isNotEmpty) {
      final media = json['_embedded']['wp:featuredmedia'][0];
      imageUrl = media['source_url'] ?? '';
    }

    // ✅ Tags
    List<String> tagsList = [];
    if (json['_embedded'] != null && json['_embedded']['wp:term'] != null) {
      final terms = json['_embedded']['wp:term'];
      // wp:term → [categories, tags]
      if (terms is List && terms.length > 1) {
        final tagArray = terms[1] as List;
        tagsList = tagArray.map((t) => t['name'].toString()).toList();
      }
    }

    // ✅ Author
    String authorName = '';
    if (json['_embedded'] != null &&
        json['_embedded']['author'] != null &&
        (json['_embedded']['author'] as List).isNotEmpty) {
      authorName = json['_embedded']['author'][0]['name'] ?? '';
    }

    // ✅ Date
    final date = json['date'] ?? '';

    return Post(
      id: json['id'] ?? 0,
      title: (json['title']?['rendered'] ?? '').toString(),
      excerpt: (json['excerpt']?['rendered'] ?? '').toString(),
      content: (json['content']?['rendered'] ?? '').toString(),
      imageUrl: imageUrl,
      tags: tagsList,
      authorName: authorName,
      date: date,
    );
  }
}
