import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resource.dart';

class ResourceService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Resource> _resources = [];
  bool _isLoading = false;
  String? _error;

  List<Resource> get resources => _resources;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ResourceService() {
    _loadResources();
  }

  Future<void> _loadResources() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // For demo purposes, use local data
      // In production, fetch from Firestore:
      // final snapshot = await _firestore.collection('resources').get();
      // _resources.clear();
      // for (var doc in snapshot.docs) {
      //   _resources.add(Resource.fromMap(doc.data(), doc.id));
      // }

      _resources.clear();
      _resources.addAll(_createMockResources());
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error loading resources: $e');
    }
  }

  List<Resource> _createMockResources() {
    final now = DateTime.now();
    
    return [
      // Featured Articles
      Resource(
        id: '1',
        title: 'Understanding Anxiety: A Complete Guide',
        description: 'Learn about anxiety disorders, their symptoms, and evidence-based coping strategies to manage anxiety effectively.',
        type: ResourceType.article,
        url: 'https://www.helpguide.org/articles/anxiety/anxiety-disorders-and-anxiety-attacks.htm',
        author: 'Mental Health Foundation',
        readTime: 8,
        tags: ['anxiety', 'mental health', 'coping strategies'],
        createdAt: now.subtract(const Duration(days: 2)),
        isFeatured: true,
      ),
      
      Resource(
        id: '2',
        title: 'The Science of Mindfulness and Meditation',
        description: 'Discover how mindfulness practices can improve your mental health and overall well-being.',
        type: ResourceType.article,
        url: 'https://www.mindful.org/the-science-of-mindfulness/',
        author: 'Mindful Magazine',
        readTime: 6,
        tags: ['mindfulness', 'meditation', 'wellness'],
        createdAt: now.subtract(const Duration(days: 5)),
        isFeatured: true,
      ),

      // Meditation Guides
      Resource(
        id: '3',
        title: '10-Minute Breathing Meditation',
        description: 'A guided breathing meditation to help you relax and reduce stress. Perfect for beginners.',
        type: ResourceType.meditation,
        url: 'https://www.youtube.com/watch?v=ZToicYcHIOU',
        duration: 10,
        tags: ['breathing', 'relaxation', 'stress relief'],
        createdAt: now.subtract(const Duration(days: 1)),
        isFeatured: true,
      ),

      Resource(
        id: '4',
        title: 'Body Scan Meditation for Sleep',
        description: 'A calming body scan meditation designed to help you fall asleep peacefully.',
        type: ResourceType.meditation,
        url: 'https://www.youtube.com/watch?v=86HUcX8ZtAk',
        duration: 20,
        tags: ['sleep', 'body scan', 'relaxation'],
        createdAt: now.subtract(const Duration(days: 3)),
      ),

      // Videos
      Resource(
        id: '5',
        title: 'TED Talk: The Power of Vulnerability',
        description: 'Brené Brown explores the concept of vulnerability and its role in building meaningful connections.',
        type: ResourceType.video,
        url: 'https://www.ted.com/talks/brene_brown_the_power_of_vulnerability',
        author: 'Brené Brown',
        duration: 20,
        tags: ['vulnerability', 'connection', 'emotional health'],
        createdAt: now.subtract(const Duration(days: 7)),
        isFeatured: true,
      ),

      Resource(
        id: '6',
        title: 'How to Build Resilience',
        description: 'Learn practical strategies to build mental resilience and bounce back from challenges.',
        type: ResourceType.video,
        url: 'https://www.youtube.com/watch?v=isBTm0RmyL8',
        author: 'Psych2Go',
        duration: 8,
        tags: ['resilience', 'mental strength', 'coping'],
        createdAt: now.subtract(const Duration(days: 4)),
      ),

      // Podcasts
      Resource(
        id: '7',
        title: 'The Happiness Lab',
        description: 'Dr. Laurie Santos explores the science of happiness and practical ways to improve your well-being.',
        type: ResourceType.podcast,
        url: 'https://www.happinesslab.fm/',
        author: 'Dr. Laurie Santos',
        tags: ['happiness', 'well-being', 'psychology'],
        createdAt: now.subtract(const Duration(days: 6)),
      ),

      // Books
      Resource(
        id: '8',
        title: 'The Mindful Way Through Depression',
        description: 'A comprehensive guide to using mindfulness-based cognitive therapy to overcome depression.',
        type: ResourceType.book,
        url: 'https://www.amazon.com/Mindful-Way-Through-Depression-Unhappiness/dp/1593851286',
        author: 'Mark Williams, John Teasdale',
        tags: ['depression', 'mindfulness', 'cognitive therapy'],
        createdAt: now.subtract(const Duration(days: 10)),
      ),

      // Tools
      Resource(
        id: '9',
        title: 'Mood Tracking Worksheet',
        description: 'Download a printable mood tracking worksheet to monitor your emotional patterns.',
        type: ResourceType.tool,
        url: 'https://www.therapistaid.com/worksheets/mood-tracking',
        tags: ['mood tracking', 'self-monitoring', 'worksheets'],
        createdAt: now.subtract(const Duration(days: 8)),
      ),

      Resource(
        id: '10',
        title: 'Crisis Hotlines Directory',
        description: 'A comprehensive list of mental health crisis hotlines and emergency resources.',
        type: ResourceType.tool,
        url: 'https://www.nimh.nih.gov/health/find-help',
        tags: ['crisis', 'emergency', 'hotlines'],
        createdAt: now.subtract(const Duration(days: 12)),
        isFeatured: true,
      ),

      // Additional Articles
      Resource(
        id: '11',
        title: 'Building Healthy Sleep Habits',
        description: 'Learn how to establish a healthy sleep routine for better mental health and well-being.',
        type: ResourceType.article,
        url: 'https://www.sleepfoundation.org/sleep-hygiene',
        author: 'National Sleep Foundation',
        readTime: 5,
        tags: ['sleep', 'habits', 'wellness'],
        createdAt: now.subtract(const Duration(days: 9)),
      ),

      Resource(
        id: '12',
        title: 'Managing Stress in College',
        description: 'Practical tips and strategies for college students to manage academic and personal stress.',
        type: ResourceType.article,
        url: 'https://www.apa.org/topics/stress/college',
        author: 'American Psychological Association',
        readTime: 7,
        tags: ['stress', 'college', 'students'],
        createdAt: now.subtract(const Duration(days: 11)),
      ),
    ];
  }

  // Get resources by type
  List<Resource> getResourcesByType(ResourceType type) {
    return _resources.where((resource) => resource.type == type).toList();
  }

  // Get featured resources
  List<Resource> getFeaturedResources() {
    return _resources.where((resource) => resource.isFeatured).toList();
  }

  // Search resources
  List<Resource> searchResources(String query) {
    if (query.isEmpty) return _resources;
    
    final lowercaseQuery = query.toLowerCase();
    return _resources.where((resource) {
      return resource.title.toLowerCase().contains(lowercaseQuery) ||
             resource.description.toLowerCase().contains(lowercaseQuery) ||
             resource.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  // Get resources by tag
  List<Resource> getResourcesByTag(String tag) {
    return _resources.where((resource) => 
      resource.tags.any((t) => t.toLowerCase() == tag.toLowerCase())
    ).toList();
  }

  // Add new resource (for admin use)
  Future<void> addResource(Resource resource) async {
    try {
      // For demo purposes, add to local list
      // In production, save to Firestore:
      // await _firestore.collection('resources').doc(resource.id).set(resource.toMap());
      
      _resources.add(resource);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding resource: $e');
      rethrow;
    }
  }

  // Update resource
  Future<void> updateResource(Resource resource) async {
    try {
      // For demo purposes, update in local list
      // In production, update in Firestore:
      // await _firestore.collection('resources').doc(resource.id).update(resource.toMap());
      
      final index = _resources.indexWhere((r) => r.id == resource.id);
      if (index != -1) {
        _resources[index] = resource;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating resource: $e');
      rethrow;
    }
  }

  // Delete resource
  Future<void> deleteResource(String resourceId) async {
    try {
      // For demo purposes, remove from local list
      // In production, delete from Firestore:
      // await _firestore.collection('resources').doc(resourceId).delete();
      
      _resources.removeWhere((resource) => resource.id == resourceId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting resource: $e');
      rethrow;
    }
  }

  // Refresh resources
  Future<void> refreshResources() async {
    await _loadResources();
  }
}
