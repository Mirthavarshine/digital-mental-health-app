import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/mood_entry.dart';

class MoodService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Uuid _uuid = const Uuid();
  
  List<MoodEntry> _moodEntries = [];
  bool _isLoading = false;

  List<MoodEntry> get moodEntries => _moodEntries;
  bool get isLoading => _isLoading;

  MoodService() {
    _loadMoodEntries();
  }

  Future<void> _loadMoodEntries() async {
    try {
      _isLoading = true;
      notifyListeners();

      // For demo purposes, create mock data
      // In production, use Firestore:
      // final snapshot = await _firestore
      //     .collection('users')
      //     .doc(_auth.currentUser!.uid)
      //     .collection('moods')
      //     .orderBy('timestamp', descending: true)
      //     .get();

      // Simulate loading delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Create mock mood entries for demo
      _moodEntries = _createMockMoodEntries();
    } catch (e) {
      debugPrint('Error loading mood entries: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshMoodEntries() async {
    await _loadMoodEntries();
  }

  List<MoodEntry> _createMockMoodEntries() {
    final now = DateTime.now();
    return [
      MoodEntry(
        id: '1',
        mood: MoodType.happy,
        note: 'Feeling great today!',
        timestamp: now.subtract(const Duration(hours: 2)),
        energyLevel: 8,
        sleepQuality: 7,
      ),
      MoodEntry(
        id: '2',
        mood: MoodType.calm,
        note: 'Peaceful morning',
        timestamp: now.subtract(const Duration(days: 1)),
        energyLevel: 6,
        sleepQuality: 8,
      ),
      MoodEntry(
        id: '3',
        mood: MoodType.excited,
        note: 'New project starting!',
        timestamp: now.subtract(const Duration(days: 2)),
        energyLevel: 9,
        sleepQuality: 6,
      ),
      MoodEntry(
        id: '4',
        mood: MoodType.neutral,
        note: 'Regular day',
        timestamp: now.subtract(const Duration(days: 3)),
        energyLevel: 5,
        sleepQuality: 7,
      ),
      MoodEntry(
        id: '5',
        mood: MoodType.stressed,
        note: 'Work pressure',
        timestamp: now.subtract(const Duration(days: 4)),
        energyLevel: 4,
        sleepQuality: 5,
      ),
    ];
  }

  Future<void> addMoodEntry({
    required MoodType mood,
    String? note,
    List<String> tags = const [],
    int energyLevel = 5,
    int sleepQuality = 5,
    List<String> activities = const [],
    String? location,
  }) async {
    try {
      final moodEntry = MoodEntry(
        id: _uuid.v4(),
        mood: mood,
        note: note,
        timestamp: DateTime.now(),
        tags: tags,
        energyLevel: energyLevel,
        sleepQuality: sleepQuality,
        activities: activities,
        location: location,
      );

      // For demo purposes, add to local list
      // In production, save to Firestore:
      // await _firestore
      //     .collection('users')
      //     .doc(_auth.currentUser!.uid)
      //     .collection('moods')
      //     .doc(moodEntry.id)
      //     .set(moodEntry.toJson());

      _moodEntries.insert(0, moodEntry);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding mood entry: $e');
      rethrow;
    }
  }

  Future<void> updateMoodEntry(MoodEntry moodEntry) async {
    try {
      // For demo purposes, update local list
      // In production, update Firestore:
      // await _firestore
      //     .collection('users')
      //     .doc(_auth.currentUser!.uid)
      //     .collection('moods')
      //     .doc(moodEntry.id)
      //     .update(moodEntry.toJson());

      final index = _moodEntries.indexWhere((entry) => entry.id == moodEntry.id);
      if (index != -1) {
        _moodEntries[index] = moodEntry;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating mood entry: $e');
      rethrow;
    }
  }

  Future<void> deleteMoodEntry(String moodEntryId) async {
    try {
      // For demo purposes, remove from local list
      // In production, delete from Firestore:
      // await _firestore
      //     .collection('users')
      //     .doc(_auth.currentUser!.uid)
      //     .collection('moods')
      //     .doc(moodEntryId)
      //     .delete();

      _moodEntries.removeWhere((entry) => entry.id == moodEntryId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting mood entry: $e');
      rethrow;
    }
  }

  List<MoodEntry> getMoodEntriesForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    return _moodEntries.where((entry) {
      return entry.timestamp.isAfter(startOfDay) && 
             entry.timestamp.isBefore(endOfDay);
    }).toList();
  }

  List<MoodEntry> getMoodEntriesForWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    
    return _moodEntries.where((entry) {
      return entry.timestamp.isAfter(weekStart) && 
             entry.timestamp.isBefore(weekEnd);
    }).toList();
  }

  List<MoodEntry> getLast7Moods() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    
    return _moodEntries.where((entry) {
      return entry.timestamp.isAfter(weekAgo);
    }).toList();
  }

  double getAverageMoodForPeriod(List<MoodEntry> entries) {
    if (entries.isEmpty) return 0.0;
    
    final total = entries.fold<double>(
      0.0, 
      (sum, entry) => sum + entry.mood.value,
    );
    
    return total / entries.length;
  }

  Map<MoodType, int> getMoodFrequency(List<MoodEntry> entries) {
    final frequency = <MoodType, int>{};
    
    for (final entry in entries) {
      frequency[entry.mood] = (frequency[entry.mood] ?? 0) + 1;
    }
    
    return frequency;
  }

  // Simple mood addition method for quick access
  Future<void> addMood(String mood) async {
    final moodType = MoodType.values.firstWhere(
      (m) => m.name.toLowerCase() == mood.toLowerCase(),
      orElse: () => MoodType.neutral,
    );
    
    await addMoodEntry(mood: moodType);
  }
}
