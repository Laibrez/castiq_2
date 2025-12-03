enum BookingStatus { pending, confirmed, completed, cancelled }

class Booking {
  final String id;
  final String jobId;
  final String modelId;
  final String brandOwnerId;
  final BookingStatus status;
  final double amount;
  final DateTime bookingDate;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.jobId,
    required this.modelId,
    required this.brandOwnerId,
    required this.status,
    required this.amount,
    required this.bookingDate,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobId': jobId,
      'modelId': modelId,
      'brandOwnerId': brandOwnerId,
      'status': status.toString(),
      'amount': amount,
      'bookingDate': bookingDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      jobId: json['jobId'],
      modelId: json['modelId'],
      brandOwnerId: json['brandOwnerId'],
      status: _parseBookingStatus(json['status']),
      amount: json['amount'],
      bookingDate: DateTime.parse(json['bookingDate']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static BookingStatus _parseBookingStatus(String status) {
    switch (status) {
      case 'BookingStatus.pending':
        return BookingStatus.pending;
      case 'BookingStatus.confirmed':
        return BookingStatus.confirmed;
      case 'BookingStatus.completed':
        return BookingStatus.completed;
      case 'BookingStatus.cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }
}
