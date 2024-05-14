import 'package:html/dom.dart' as dom;

class Article {
  final String title;
  final String url;
  final String imageUrl;
  final String description;
  final String category;

  Article(
      {required this.title,
      required this.url,
      required this.imageUrl,
      required this.description,
      required this.category});

  // Factory constructor to create a NewsArticle from parsed HTML data
  factory Article.fromElement(dom.Element element) {
    var title = element.attributes['title'] ?? 'No title';
    var url = element.attributes['href'] ?? 'No URL';
    var imageElement = element.querySelector('img');
    var imageUrl = imageElement?.attributes['data-src'] ??
        imageElement?.attributes['src'] ??
        'No image URL';
    var description = element.querySelector('p')?.text ?? 'No description';
    var category = url.split('/')[1];

    return Article(
        title: title,
        url: url,
        imageUrl: imageUrl,
        description: description,
        category: category);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
    };
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      category: json['category'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article && other.url == url; // Compare URLs for equality
  }

  @override
  int get hashCode => url.hashCode; // Use URL's hash code for equality
}
