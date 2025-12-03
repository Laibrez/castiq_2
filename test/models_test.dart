import 'package:flutter_test/flutter_test.dart';
import 'package:castiq/models/user.dart';
import 'package:castiq/models/job.dart';
import 'package:castiq/models/booking.dart';
import 'package:castiq/models/portfolio_item.dart';

void main() {
  group('User Model Tests', () {
    test('User creation with required fields', () {
      final user = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        userType: UserType.model,
      );

      expect(user.id, '1');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.userType, UserType.model);
      expect(user.isVerified, false);
    });

    test('User toJson and fromJson', () {
      final user = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        userType: UserType.model,
        isVerified: true,
      );

      final json = user.toJson();
      final userFromJson = User.fromJson(json);

      expect(userFromJson.id, user.id);
      expect(userFromJson.email, user.email);
      expect(userFromJson.name, user.name);
      expect(userFromJson.userType, user.userType);
      expect(userFromJson.isVerified, user.isVerified);
    });
  });

  group('Job Model Tests', () {
    test('Job creation', () {
      final job = Job(
        id: '1',
        brandOwnerId: 'brand1',
        title: 'Test Job',
        description: 'Test Description',
        location: 'Test Location',
        budget: 5000,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 10),
        requirements: ['Requirement 1', 'Requirement 2'],
        status: JobStatus.open,
        createdAt: DateTime.now(),
      );

      expect(job.id, '1');
      expect(job.title, 'Test Job');
      expect(job.budget, 5000);
      expect(job.status, JobStatus.open);
      expect(job.requirements.length, 2);
    });

    test('Job toJson and fromJson', () {
      final job = Job(
        id: '1',
        brandOwnerId: 'brand1',
        title: 'Test Job',
        description: 'Test Description',
        location: 'Test Location',
        budget: 5000,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 10),
        requirements: ['Requirement 1'],
        status: JobStatus.open,
        createdAt: DateTime.now(),
      );

      final json = job.toJson();
      final jobFromJson = Job.fromJson(json);

      expect(jobFromJson.id, job.id);
      expect(jobFromJson.title, job.title);
      expect(jobFromJson.budget, job.budget);
      expect(jobFromJson.status, job.status);
    });
  });

  group('Booking Model Tests', () {
    test('Booking creation', () {
      final booking = Booking(
        id: '1',
        jobId: 'job1',
        modelId: 'model1',
        brandOwnerId: 'brand1',
        status: BookingStatus.pending,
        amount: 5000,
        bookingDate: DateTime.now(),
        createdAt: DateTime.now(),
      );

      expect(booking.id, '1');
      expect(booking.status, BookingStatus.pending);
      expect(booking.amount, 5000);
    });

    test('Booking status parsing', () {
      final statuses = {
        'BookingStatus.pending': BookingStatus.pending,
        'BookingStatus.confirmed': BookingStatus.confirmed,
        'BookingStatus.completed': BookingStatus.completed,
        'BookingStatus.cancelled': BookingStatus.cancelled,
      };

      statuses.forEach((statusString, expectedStatus) {
        final booking = Booking.fromJson({
          'id': '1',
          'jobId': 'job1',
          'modelId': 'model1',
          'brandOwnerId': 'brand1',
          'status': statusString,
          'amount': 5000.0,
          'bookingDate': DateTime.now().toIso8601String(),
          'createdAt': DateTime.now().toIso8601String(),
        });

        expect(booking.status, expectedStatus);
      });
    });
  });

  group('PortfolioItem Model Tests', () {
    test('PortfolioItem creation for image', () {
      final item = PortfolioItem(
        id: '1',
        userId: 'user1',
        type: MediaType.image,
        url: '/path/to/image.jpg',
        uploadedAt: DateTime.now(),
      );

      expect(item.id, '1');
      expect(item.type, MediaType.image);
      expect(item.url, '/path/to/image.jpg');
    });

    test('PortfolioItem creation for video', () {
      final item = PortfolioItem(
        id: '1',
        userId: 'user1',
        type: MediaType.video,
        url: '/path/to/video.mp4',
        thumbnail: '/path/to/thumbnail.jpg',
        caption: 'Test Video',
        uploadedAt: DateTime.now(),
      );

      expect(item.type, MediaType.video);
      expect(item.thumbnail, '/path/to/thumbnail.jpg');
      expect(item.caption, 'Test Video');
    });

    test('PortfolioItem toJson and fromJson', () {
      final item = PortfolioItem(
        id: '1',
        userId: 'user1',
        type: MediaType.image,
        url: '/path/to/image.jpg',
        caption: 'Test Image',
        uploadedAt: DateTime.now(),
      );

      final json = item.toJson();
      final itemFromJson = PortfolioItem.fromJson(json);

      expect(itemFromJson.id, item.id);
      expect(itemFromJson.type, item.type);
      expect(itemFromJson.url, item.url);
      expect(itemFromJson.caption, item.caption);
    });
  });
}
