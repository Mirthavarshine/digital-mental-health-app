import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking.dart';

class BookingService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  BookingService() {
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // For demo purposes, use local data
      // In production, fetch from Firestore:
      // final snapshot = await _firestore.collection('bookings').get();
      // _bookings.clear();
      // for (var doc in snapshot.docs) {
      //   _bookings.add(Booking.fromMap(doc.data(), doc.id));
      // }

      _bookings.clear();
      _bookings.addAll(_createMockBookings());
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error loading bookings: $e');
    }
  }

  List<Booking> _createMockBookings() {
    final now = DateTime.now();
    
    return [
      Booking(
        id: '1',
        name: 'Sarah Johnson',
        email: 'sarah.johnson@email.com',
        phone: '+1 (555) 123-4567',
        preferredDate: now.add(const Duration(days: 2)),
        preferredTime: '10:00 AM',
        preferredCounselor: 'Dr. Emily Chen',
        reason: 'Anxiety and stress management',
        urgency: 'medium',
        status: BookingStatus.confirmed,
        createdAt: now.subtract(const Duration(days: 1)),
        notes: 'Prefers morning sessions',
      ),
      Booking(
        id: '2',
        name: 'Michael Rodriguez',
        email: 'mike.rodriguez@email.com',
        phone: '+1 (555) 987-6543',
        preferredDate: now.add(const Duration(days: 5)),
        preferredTime: '2:00 PM',
        preferredCounselor: 'Dr. James Wilson',
        reason: 'Depression support',
        urgency: 'high',
        status: BookingStatus.pending,
        createdAt: now.subtract(const Duration(hours: 3)),
        notes: 'First-time counseling',
      ),
    ];
  }

  Future<String> createBooking({
    required String name,
    required String email,
    required String phone,
    required DateTime preferredDate,
    required String preferredTime,
    required String preferredCounselor,
    required String reason,
    required String urgency,
    String? notes,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        preferredDate: preferredDate,
        preferredTime: preferredTime,
        preferredCounselor: preferredCounselor,
        reason: reason,
        urgency: urgency,
        status: BookingStatus.pending,
        createdAt: DateTime.now(),
        notes: notes,
      );

      // For demo purposes, add to local list
      // In production, save to Firestore:
      // await _firestore.collection('bookings').doc(booking.id).set(booking.toMap());

      _bookings.insert(0, booking);
      _isLoading = false;
      notifyListeners();

      return booking.id;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error creating booking: $e');
      rethrow;
    }
  }

  Future<void> updateBooking(Booking booking) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // For demo purposes, update in local list
      // In production, update in Firestore:
      // await _firestore.collection('bookings').doc(booking.id).update(booking.toMap());

      final index = _bookings.indexWhere((b) => b.id == booking.id);
      if (index != -1) {
        _bookings[index] = booking;
        notifyListeners();
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error updating booking: $e');
      rethrow;
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // For demo purposes, update in local list
      // In production, update in Firestore:
      // await _firestore.collection('bookings').doc(bookingId).update({
      //   'status': BookingStatus.cancelled.name,
      //   'updatedAt': DateTime.now().toIso8601String(),
      // });

      final index = _bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        _bookings[index] = _bookings[index].copyWith(
          status: BookingStatus.cancelled,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error cancelling booking: $e');
      rethrow;
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // For demo purposes, remove from local list
      // In production, delete from Firestore:
      // await _firestore.collection('bookings').doc(bookingId).delete();

      _bookings.removeWhere((booking) => booking.id == bookingId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error deleting booking: $e');
      rethrow;
    }
  }

  // Get bookings by status
  List<Booking> getBookingsByStatus(BookingStatus status) {
    return _bookings.where((booking) => booking.status == status).toList();
  }

  // Get upcoming bookings
  List<Booking> getUpcomingBookings() {
    final now = DateTime.now();
    return _bookings.where((booking) => 
      booking.preferredDate.isAfter(now) && 
      booking.status != BookingStatus.cancelled
    ).toList();
  }

  // Get bookings for a specific date
  List<Booking> getBookingsForDate(DateTime date) {
    return _bookings.where((booking) => 
      booking.preferredDate.year == date.year &&
      booking.preferredDate.month == date.month &&
      booking.preferredDate.day == date.day
    ).toList();
  }

  // Search bookings
  List<Booking> searchBookings(String query) {
    if (query.isEmpty) return _bookings;
    
    final lowercaseQuery = query.toLowerCase();
    return _bookings.where((booking) {
      return booking.name.toLowerCase().contains(lowercaseQuery) ||
             booking.email.toLowerCase().contains(lowercaseQuery) ||
             booking.reason.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  // Get available time slots for a date
  List<String> getAvailableTimeSlots(DateTime date) {
    final bookedSlots = getBookingsForDate(date)
        .where((booking) => booking.status != BookingStatus.cancelled)
        .map((booking) => booking.preferredTime)
        .toList();

    final allSlots = [
      '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
      '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM'
    ];

    return allSlots.where((slot) => !bookedSlots.contains(slot)).toList();
  }

  // Get available counselors
  List<String> getAvailableCounselors() {
    return [
      'Dr. Emily Chen - Anxiety & Stress Specialist',
      'Dr. James Wilson - Depression & Mood Disorders',
      'Dr. Sarah Martinez - Trauma & PTSD Specialist',
      'Dr. Michael Thompson - Family & Relationship Therapy',
      'Dr. Lisa Park - Cognitive Behavioral Therapy',
    ];
  }

  // Refresh bookings
  Future<void> refreshBookings() async {
    await _loadBookings();
  }
}
