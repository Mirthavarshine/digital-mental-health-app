import 'package:equatable/equatable.dart';

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

extension BookingStatusExtension on BookingStatus {
  String get displayName {
    switch (this) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.completed:
        return 'Completed';
    }
  }

  String get color {
    switch (this) {
      case BookingStatus.pending:
        return '#FF9800'; // Orange
      case BookingStatus.confirmed:
        return '#4CAF50'; // Green
      case BookingStatus.cancelled:
        return '#F44336'; // Red
      case BookingStatus.completed:
        return '#2196F3'; // Blue
    }
  }
}

class Booking extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime preferredDate;
  final String preferredTime;
  final String preferredCounselor;
  final String reason;
  final String urgency;
  final BookingStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;
  final String? counselorNotes;

  const Booking({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.preferredDate,
    required this.preferredTime,
    required this.preferredCounselor,
    required this.reason,
    required this.urgency,
    this.status = BookingStatus.pending,
    required this.createdAt,
    this.updatedAt,
    this.notes,
    this.counselorNotes,
  });

  factory Booking.fromMap(Map<String, dynamic> data, String id) {
    return Booking(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      preferredDate: DateTime.parse(data['preferredDate'] ?? DateTime.now().toIso8601String()),
      preferredTime: data['preferredTime'] ?? '',
      preferredCounselor: data['preferredCounselor'] ?? '',
      reason: data['reason'] ?? '',
      urgency: data['urgency'] ?? 'medium',
      status: BookingStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => BookingStatus.pending,
      ),
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: data['updatedAt'] != null ? DateTime.parse(data['updatedAt']) : null,
      notes: data['notes'],
      counselorNotes: data['counselorNotes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'preferredDate': preferredDate.toIso8601String(),
      'preferredTime': preferredTime,
      'preferredCounselor': preferredCounselor,
      'reason': reason,
      'urgency': urgency,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'notes': notes,
      'counselorNotes': counselorNotes,
    };
  }

  Booking copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    DateTime? preferredDate,
    String? preferredTime,
    String? preferredCounselor,
    String? reason,
    String? urgency,
    BookingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    String? counselorNotes,
  }) {
    return Booking(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      preferredDate: preferredDate ?? this.preferredDate,
      preferredTime: preferredTime ?? this.preferredTime,
      preferredCounselor: preferredCounselor ?? this.preferredCounselor,
      reason: reason ?? this.reason,
      urgency: urgency ?? this.urgency,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      counselorNotes: counselorNotes ?? this.counselorNotes,
    );
  }

  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${preferredDate.day} ${months[preferredDate.month - 1]} ${preferredDate.year}';
  }

  String get formattedDateTime {
    return '$formattedDate at $preferredTime';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        preferredDate,
        preferredTime,
        preferredCounselor,
        reason,
        urgency,
        status,
        createdAt,
        updatedAt,
        notes,
        counselorNotes,
      ];
}
