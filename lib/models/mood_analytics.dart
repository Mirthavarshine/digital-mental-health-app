import 'package:equatable/equatable.dart';
import 'mood_entry.dart';

class MoodAnalytics extends Equatable {
  final double averageMood;
  final MoodType mostCommonMood;
  final int totalEntries;
  final DateTime startDate;
  final DateTime endDate;
  final List<MoodDataPoint> dailyMoods;
  final List<MoodDataPoint> weeklyMoods;
  final List<MoodDataPoint> monthlyMoods;
  final Map<MoodType, int> moodFrequency;
  final List<String> topActivities;
  final List<String> topTags;
  final double averageEnergyLevel;
  final double averageSleepQuality;
  final List<MoodInsight> insights;

  const MoodAnalytics({
    required this.averageMood,
    required this.mostCommonMood,
    required this.totalEntries,
    required this.startDate,
    required this.endDate,
    required this.dailyMoods,
    required this.weeklyMoods,
    required this.monthlyMoods,
    required this.moodFrequency,
    required this.topActivities,
    required this.topTags,
    required this.averageEnergyLevel,
    required this.averageSleepQuality,
    required this.insights,
  });

  Map<String, dynamic> toJson() {
    return {
      'averageMood': averageMood,
      'mostCommonMood': mostCommonMood.name,
      'totalEntries': totalEntries,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'dailyMoods': dailyMoods.map((e) => e.toJson()).toList(),
      'weeklyMoods': weeklyMoods.map((e) => e.toJson()).toList(),
      'monthlyMoods': monthlyMoods.map((e) => e.toJson()).toList(),
      'moodFrequency': moodFrequency.map((k, v) => MapEntry(k.name, v)),
      'topActivities': topActivities,
      'topTags': topTags,
      'averageEnergyLevel': averageEnergyLevel,
      'averageSleepQuality': averageSleepQuality,
      'insights': insights.map((e) => e.toJson()).toList(),
    };
  }

  factory MoodAnalytics.fromJson(Map<String, dynamic> json) {
    return MoodAnalytics(
      averageMood: json['averageMood'] as double,
      mostCommonMood: MoodType.values.firstWhere(
        (e) => e.name == json['mostCommonMood'],
        orElse: () => MoodType.neutral,
      ),
      totalEntries: json['totalEntries'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      dailyMoods: (json['dailyMoods'] as List)
          .map((e) => MoodDataPoint.fromJson(e))
          .toList(),
      weeklyMoods: (json['weeklyMoods'] as List)
          .map((e) => MoodDataPoint.fromJson(e))
          .toList(),
      monthlyMoods: (json['monthlyMoods'] as List)
          .map((e) => MoodDataPoint.fromJson(e))
          .toList(),
      moodFrequency: (json['moodFrequency'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(
                MoodType.values.firstWhere((e) => e.name == k),
                v as int,
              )),
      topActivities: List<String>.from(json['topActivities']),
      topTags: List<String>.from(json['topTags']),
      averageEnergyLevel: json['averageEnergyLevel'] as double,
      averageSleepQuality: json['averageSleepQuality'] as double,
      insights: (json['insights'] as List)
          .map((e) => MoodInsight.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        averageMood,
        mostCommonMood,
        totalEntries,
        startDate,
        endDate,
        dailyMoods,
        weeklyMoods,
        monthlyMoods,
        moodFrequency,
        topActivities,
        topTags,
        averageEnergyLevel,
        averageSleepQuality,
        insights,
      ];
}

class MoodDataPoint extends Equatable {
  final DateTime date;
  final double moodValue;
  final MoodType mood;
  final int count;

  const MoodDataPoint({
    required this.date,
    required this.moodValue,
    required this.mood,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'moodValue': moodValue,
      'mood': mood.name,
      'count': count,
    };
  }

  factory MoodDataPoint.fromJson(Map<String, dynamic> json) {
    return MoodDataPoint(
      date: DateTime.parse(json['date'] as String),
      moodValue: json['moodValue'] as double,
      mood: MoodType.values.firstWhere(
        (e) => e.name == json['mood'],
        orElse: () => MoodType.neutral,
      ),
      count: json['count'] as int,
    );
  }

  @override
  List<Object?> get props => [date, moodValue, mood, count];
}

class MoodInsight extends Equatable {
  final String title;
  final String description;
  final InsightType type;
  final InsightSeverity severity;
  final List<String> suggestions;

  const MoodInsight({
    required this.title,
    required this.description,
    required this.type,
    required this.severity,
    this.suggestions = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type.name,
      'severity': severity.name,
      'suggestions': suggestions,
    };
  }

  factory MoodInsight.fromJson(Map<String, dynamic> json) {
    return MoodInsight(
      title: json['title'] as String,
      description: json['description'] as String,
      type: InsightType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => InsightType.general,
      ),
      severity: InsightSeverity.values.firstWhere(
        (e) => e.name == json['severity'],
        orElse: () => InsightSeverity.info,
      ),
      suggestions: List<String>.from(json['suggestions'] ?? []),
    );
  }

  @override
  List<Object?> get props => [title, description, type, severity, suggestions];
}

enum InsightType {
  trend,
  pattern,
  correlation,
  recommendation,
  warning,
  achievement,
  general,
}

enum InsightSeverity {
  info,
  low,
  medium,
  high,
  critical,
}
