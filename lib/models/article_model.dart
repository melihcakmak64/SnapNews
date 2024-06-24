import 'package:html/dom.dart' as dom;

class Article {
  final String title;
  final String url;
  final String imageUrl;
  final String description;
  final String category;
  final Map<String, String>? content; // Nullable content attribute

  Article({
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.description,
    required this.category,
    this.content,
  });

  // Factory constructor to create an Article from parsed HTML data
  factory Article.fromElement(dom.Element element) {
    var title = element.attributes['title'] ?? 'No title';
    var url = element.attributes['href'] ?? 'No URL';
    var imageElement = element.querySelector('img');
    var imageUrl = imageElement?.attributes['data-src'] ??
        imageElement?.attributes['src'] ??
        'No image URL';
    var description = element.querySelector('p')?.text ?? 'No description';
    var category = url.split('/')[1];

    // Example of parsing content from HTML (update this logic based on your actual HTML structure)
    Map<String, String>? content;
    var contentElements = element.querySelectorAll('.content-section');
    if (contentElements.isNotEmpty) {
      content = {};
      for (var section in contentElements) {
        var heading = section.querySelector('h2')?.text ?? 'No heading';
        var body = section.querySelector('p')?.text ?? 'No content';
        content[heading] = body;
      }
    }

    return Article(
        title: title,
        url: url,
        imageUrl: imageUrl,
        description: description,
        category: category,
        content: content);
  }

  factory Article.fromGlobal(dom.Element element) {
    var titleElement = element.querySelector('.ui-story-headline a');
    var title = titleElement?.text ?? 'No title';

    var url = titleElement?.attributes['href'] ?? 'No URL';
    var imageElement = element.querySelector('img');
    var imageUrl = imageElement?.attributes['src'] ?? 'No image URL';
    var description =
        element.querySelector('.ui-story-meta')?.text ?? 'No description';
    var categoryElement = element.querySelector('.ui-label[data-type="tag"]');
    var categoryHref = categoryElement?.attributes['href'] ?? '';
    var category = categoryHref.split('/').last ?? 'No category';

    return Article(
      title: title,
      url: url,
      imageUrl: imageUrl,
      description: description,
      category: category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'content': content,
    };
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      category: json['category'],
      content: Map<String, String>.from(json['content'] ?? {}),
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
