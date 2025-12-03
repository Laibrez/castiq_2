import 'package:flutter/foundation.dart';
import '../models/job.dart';

class JobProvider extends ChangeNotifier {
  List<Job> _jobs = [];
  bool _isLoading = false;

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;

  Future<void> loadJobs() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - replace with actual API call
      _jobs = _generateMockJobs();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createJob(Job job) async {
    _jobs.insert(0, job);
    notifyListeners();
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
  }

  List<Job> _generateMockJobs() {
    return [
      Job(
        id: '1',
        brandOwnerId: 'brand1',
        title: 'Fashion Photoshoot',
        description: 'Looking for models for a summer collection photoshoot',
        location: 'New York, NY',
        budget: 5000,
        startDate: DateTime.now().add(const Duration(days: 7)),
        endDate: DateTime.now().add(const Duration(days: 10)),
        requirements: ['Height: 5\'8"+', 'Experience: 2+ years', 'Portfolio required'],
        status: JobStatus.open,
        createdAt: DateTime.now(),
      ),
      Job(
        id: '2',
        brandOwnerId: 'brand2',
        title: 'Commercial Shoot',
        description: 'Need models for a commercial advertisement campaign',
        location: 'Los Angeles, CA',
        budget: 3500,
        startDate: DateTime.now().add(const Duration(days: 14)),
        endDate: DateTime.now().add(const Duration(days: 16)),
        requirements: ['Age: 25-35', 'Professional demeanor', 'Experience in commercials'],
        status: JobStatus.open,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}
