import 'package:equatable/equatable.dart';

enum MoodType {
  veryHappy,
  happy,
  neutral,
  sad,
  verySad,
  anxious,
  stressed,
  excited,
  calm,
  angry,
  frustrated,
  grateful,
  hopeful,
  overwhelmed,
  content,
}

extension MoodTypeExtension on MoodType {
  String get emoji {
    switch (this) {
      case MoodType.veryHappy:
        return '😄';
      case MoodType.happy:
        return '😊';
      case MoodType.neutral:
        return '😐';
      case MoodType.sad:
        return '😢';
      case MoodType.verySad:
        return '😭';
      case MoodType.anxious:
        return '😰';
      case MoodType.stressed:
        return '😤';
      case MoodType.excited:
        return '🤩';
      case MoodType.calm:
        return '😌';
      case MoodType.angry:
        return '😠';
      case MoodType.frustrated:
        return '😤';
      case MoodType.grateful:
        return '🙏';
      case MoodType.hopeful:
        return '🤗';
      case MoodType.overwhelmed:
        return '😵';
      case MoodType.content:
        return '😊';
    }
  }

  String get name {
    switch (this) {
      case MoodType.veryHappy:
        return 'Very Happy';
      case MoodType.happy:
        return 'Happy';
      case MoodType.neutral:
        return 'Neutral';
      case MoodType.sad:
        return 'Sad';
      case MoodType.verySad:
        return 'Very Sad';
      case MoodType.anxious:
        return 'Anxious';
      case MoodType.stressed:
        return 'Stressed';
      case MoodType.excited:
        return 'Excited';
      case MoodType.calm:
        return 'Calm';
      case MoodType.angry:
        return 'Angry';
      case MoodType.frustrated:
        return 'Frustrated';
      case MoodType.grateful:
        return 'Grateful';
      case MoodType.hopeful:
        return 'Hopeful';
      case MoodType.overwhelmed:
        return 'Overwhelmed';
      case MoodType.content:
        return 'Content';
    }
  }

  double get value {
    switch (this) {
      case MoodType.verySad:
        return 1.0;
      case MoodType.sad:
        return 2.0;
      case MoodType.anxious:
        return 2.5;
      case MoodType.stressed:
        return 3.0;
      case MoodType.frustrated:
        return 3.5;
      case MoodType.angry:
        return 4.0;
      case MoodType.overwhelmed:
        return 4.5;
      case MoodType.neutral:
        return 5.0;
      case MoodType.calm:
        return 6.0;
      case MoodType.content:
        return 7.0;
      case MoodType.hopeful:
        return 7.5;
      case MoodType.grateful:
        return 8.0;
      case MoodType.happy:
        return 8.5;
      case MoodType.excited:
        return 9.0;
      case MoodType.veryHappy:
        return 10.0;
    }
  }
}

class MoodEntry extends Equatable {
  final String id;
  final MoodType mood;
  final String? note;
  final DateTime timestamp;
  final List<String> tags;
  final int energyLevel; // 1-10 scale
  final int sleepQuality; // 1-10 scale
  final List<String> activities;
  final String? location;

  const MoodEntry({
    required this.id,
    required this.mood,
    this.note,
    required this.timestamp,
    this.tags = const [],
    this.energyLevel = 5,
    this.sleepQuality = 5,
    this.activities = const [],
    this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mood': mood.name,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
      'tags': tags,
      'energyLevel': energyLevel,
      'sleepQuality': sleepQuality,
      'activities': activities,
      'location': location,
    };
  }

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      id: json['id'] as String,
      mood: MoodType.values.firstWhere(
        (e) => e.name == json['mood'],
        orElse: () => MoodType.neutral,
      ),
      note: json['note'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      tags: List<String>.from(json['tags'] ?? []),
      energyLevel: json['energyLevel'] as int? ?? 5,
      sleepQuality: json['sleepQuality'] as int? ?? 5,
      activities: List<String>.from(json['activities'] ?? []),
      location: json['location'] as String?,
    );
  }

  MoodEntry copyWith({
    String? id,
    MoodType? mood,
    String? note,
    DateTime? timestamp,
    List<String>? tags,
    int? energyLevel,
    int? sleepQuality,
    List<String>? activities,
    String? location,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      tags: tags ?? this.tags,
      energyLevel: energyLevel ?? this.energyLevel,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      activities: activities ?? this.activities,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [
        id,
        mood,
        note,
        timestamp,
        tags,
        energyLevel,
        sleepQuality,
        activities,
        location,
      ];
}
