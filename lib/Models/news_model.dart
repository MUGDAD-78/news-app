class NewsModel {
  String title;
  String description;
  String urlToImage;
  String publishedAt;
  String author;
  String content;

  NewsModel(
      {required this.title,
      required this.description,
      required this.urlToImage,
      required this.publishedAt,
      required this.author,
      required this.content});

  factory NewsModel.fromJson(Map<String, dynamic> jsonData) {
    return NewsModel(
        title: jsonData['title'].toString(),
        description: jsonData['description'].toString(),
        urlToImage: jsonData['urlToImage'].toString(),
        publishedAt: jsonData['publishedAt'].toString(),
        author: jsonData['author'].toString(),
        content: jsonData['content'].toString());
  }
}
