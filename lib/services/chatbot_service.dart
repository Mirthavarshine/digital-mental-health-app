import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isTyping;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isTyping = false,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    bool? isUser,
    DateTime? timestamp,
    bool? isTyping,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class ChatbotService extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  
  // OpenAI API configuration
  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';
  
  // For demo purposes, we'll use mock responses
  // In production, add your OpenAI API key here
  static const String _apiKey = 'demo-api-key';

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  ChatbotService() {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: "Hello! I'm your AI Mental Health Assistant. I'm here to support you on your mental health journey. How are you feeling today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    
    _messages.add(userMessage);
    notifyListeners();

    // Add typing indicator
    final typingMessage = ChatMessage(
      id: 'typing-${DateTime.now().millisecondsSinceEpoch}',
      text: 'Bot is typing...',
      isUser: false,
      timestamp: DateTime.now(),
      isTyping: true,
    );
    
    _messages.add(typingMessage);
    notifyListeners();

    // Get AI response
    await _getAIResponse(text);
  }

  Future<void> _getAIResponse(String userMessage) async {
    try {
      _isLoading = true;
      
      // Remove typing indicator
      _messages.removeWhere((msg) => msg.isTyping);
      
      // For demo purposes, we'll use a mock response
      // In production, replace this with actual OpenAI API call
      final response = await _getMockResponse(userMessage);
      
      final aiMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      
      _messages.add(aiMessage);
    } catch (e) {
      debugPrint('Error getting AI response: $e');
      
      // Remove typing indicator
      _messages.removeWhere((msg) => msg.isTyping);
      
      final errorMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: "I'm sorry, I'm having trouble responding right now. Please try again later.",
        isUser: false,
        timestamp: DateTime.now(),
      );
      
      _messages.add(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> _getMockResponse(String userMessage) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    final message = userMessage.toLowerCase();
    
    if (message.contains('sad') || message.contains('depressed') || message.contains('down')) {
      return "I understand you're feeling sad right now. It's completely okay to feel this way - emotions are a natural part of being human. Remember that feelings are temporary, even when they feel overwhelming. Would you like to talk about what's making you feel this way? I'm here to listen without judgment.";
    } else if (message.contains('anxious') || message.contains('worried') || message.contains('nervous')) {
      return "Anxiety can feel overwhelming, but you're not alone in this. Try taking slow, deep breaths - inhale for 4 counts, hold for 4, and exhale for 6. What specific thoughts or situations are making you feel anxious? Sometimes talking about our worries can help us process them better.";
    } else if (message.contains('happy') || message.contains('good') || message.contains('great')) {
      return "That's wonderful to hear! I'm genuinely happy that you're feeling positive. Celebrating good moments is important for our mental health. What's contributing to your good mood today? It's helpful to recognize what brings us joy so we can cultivate more of those experiences.";
    } else if (message.contains('help') || message.contains('support') || message.contains('crisis')) {
      return "I'm here to support you, and I want you to know that reaching out for help is a sign of strength, not weakness. If you're in immediate crisis, please contact emergency services or a crisis helpline. For ongoing support, consider speaking with a mental health professional, trusted friend, or family member. You don't have to face this alone.";
    } else if (message.contains('stress') || message.contains('stressed') || message.contains('overwhelmed')) {
      return "Stress is a common experience, and it sounds like you're dealing with a lot right now. Try breaking overwhelming tasks into smaller, manageable steps. What's causing you the most stress? Sometimes identifying the source can help us find practical solutions or coping strategies.";
    } else if (message.contains('sleep') || message.contains('tired') || message.contains('exhausted')) {
      return "Sleep and rest are crucial for our mental health. If you're having trouble sleeping, try establishing a calming bedtime routine - perhaps reading, gentle stretching, or meditation. Avoid screens an hour before bed and try to maintain consistent sleep and wake times. How has your sleep been affecting your mood?";
    } else if (message.contains('lonely') || message.contains('isolated') || message.contains('alone')) {
      return "Feeling lonely can be really difficult, and I want you to know that your feelings are valid. Connection with others is a fundamental human need. Even small interactions can help - perhaps reaching out to a friend, joining a community group, or engaging in activities you enjoy. What kind of connection are you looking for right now?";
    } else {
      return "Thank you for sharing that with me. I'm here to listen and support you without judgment. Every conversation we have is a step forward in your mental health journey. How can I help you feel better today? Is there something specific you'd like to explore or work through together?";
    }
  }

  Future<String> _getOpenAIResponse(String userMessage) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a supportive, empathetic mental health assistant. Provide helpful, encouraging responses to users seeking mental health support. Keep responses conversational, warm, and supportive. Always encourage professional help when appropriate. Keep responses concise but meaningful.',
          },
          {
            'role': 'user',
            'content': userMessage,
          },
        ],
        'max_tokens': 200,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get AI response: ${response.statusCode}');
    }
  }

  void clearMessages() {
    _messages.clear();
    _addWelcomeMessage();
    notifyListeners();
  }

  // Method to send a simple message (for quick access)
  Future<void> sendQuickMessage(String message) async {
    await sendMessage(message);
  }
}
