import 'package:equatable/equatable.dart';

enum ResourceType {
  article,
  meditation,
  video,
  podcast,
  book,
  tool,
}

extension ResourceTypeExtension on ResourceType {
  String get displayName {
    switch (this) {
      case ResourceType.article:
        return 'Article';
      case ResourceType.meditation:
        return 'Meditation';
      case ResourceType.video:
        return 'Video';
      case ResourceType.podcast:
        return 'Podcast';
      case ResourceType.book:
        return 'Book';
      case ResourceType.tool:
        return 'Tool';
    }
  }

  String get icon {
    switch (this) {
      case ResourceType.article:
        return '📄';
      case ResourceType.meditation:
        return '🧘';
      case ResourceType.video:
        return '🎥';
      case ResourceType.podcast:
        return '🎧';
      case ResourceType.book:
        return '📚';
      case ResourceType.tool:
        return '🛠️';
    }
  }

  String get color {
    switch (this) {
      case ResourceType.article:
        return '#4CAF50'; // Green
      case ResourceType.meditation:
        return '#9C27B0'; // Purple
      case ResourceType.video:
        return '#F44336'; // Red
      case ResourceType.podcast:
        return '#FF9800'; // Orange
      case ResourceType.book:
        return '#2196F3'; // Blue
      case ResourceType.tool:
        return '#607D8B'; // Blue Grey
    }
  }
}

class Resource extends Equatable {
  final String id;
  final String title;
  final String description;
  final ResourceType type;
  final String url;
  final String? thumbnailUrl;
  final String? author;
  final int? duration; // in minutes
  final List<String> tags;
  final DateTime createdAt;
  final bool isFeatured;
  final int? readTime; // in minutes for articles

  const Resource({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.author,
    this.duration,
    this.tags = const [],
    required this.createdAt,
    this.isFeatured = false,
    this.readTime,
  });

  factory Resource.fromMap(Map<String, dynamic> data, String id) {
    return Resource(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      type: ResourceType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => ResourceType.article,
      ),
      url: data['url'] ?? '',
      thumbnailUrl: data['thumbnailUrl'],
      author: data['author'],
      duration: data['duration'],
      tags: List<String>.from(data['tags'] ?? []),
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toIso8601String()),
      isFeatured: data['isFeatured'] ?? false,
      readTime: data['readTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'type': type.name,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'author': author,
      'duration': duration,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'isFeatured': isFeatured,
      'readTime': readTime,
    };
  }

  Resource copyWith({
    String? id,
    String? title,
    String? description,
    ResourceType? type,
    String? url,
    String? thumbnailUrl,
    String? author,
    int? duration,
    List<String>? tags,
    DateTime? createdAt,
    bool? isFeatured,
    int? readTime,
  }) {
    return Resource(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      author: author ?? this.author,
      duration: duration ?? this.duration,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      isFeatured: isFeatured ?? this.isFeatured,
      readTime: readTime ?? this.readTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        url,
        thumbnailUrl,
        author,
        duration,
        tags,
        createdAt,
        isFeatured,
        readTime,
      ];
}
