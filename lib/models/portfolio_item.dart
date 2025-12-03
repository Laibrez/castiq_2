enum MediaType { image, video }

class PortfolioItem {
  final String id;
  final String userId;
  final MediaType type;
  final String url;
  final String? thumbnail;
  final String? caption;
  final DateTime uploadedAt;

  PortfolioItem({
    required this.id,
    required this.userId,
    required this.type,
    required this.url,
    this.thumbnail,
    this.caption,
    required this.uploadedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.toString(),
      'url': url,
      'thumbnail': thumbnail,
      'caption': caption,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }

  factory PortfolioItem.fromJson(Map<String, dynamic> json) {
    return PortfolioItem(
      id: json['id'],
      userId: json['userId'],
      type: json['type'] == 'MediaType.image'
          ? MediaType.image
          : MediaType.video,
      url: json['url'],
      thumbnail: json['thumbnail'],
      caption: json['caption'],
      uploadedAt: DateTime.parse(json['uploadedAt']),
    );
  }
}
