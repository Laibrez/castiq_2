import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import 'package:intl/intl.dart';

class MatchmakerScreen extends StatefulWidget {
  const MatchmakerScreen({super.key});

  @override
  State<MatchmakerScreen> createState() => _MatchmakerScreenState();
}

class _MatchmakerScreenState extends State<MatchmakerScreen> {
  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.loadJobs();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isModel = authProvider.currentUser?.userType == UserType.model;

    return Scaffold(
      appBar: AppBar(
        title: Text(isModel ? 'Find Jobs' : 'Find Models'),
      ),
      body: Consumer<JobProvider>(
        builder: (context, jobProvider, child) {
          if (jobProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (isModel) {
            return _buildJobsList(jobProvider);
          } else {
            return _buildModelsList();
          }
        },
      ),
    );
  }

  Widget _buildJobsList(JobProvider jobProvider) {
    if (jobProvider.jobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline,
              size: 80,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No Jobs Available',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for new opportunities',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadJobs,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jobProvider.jobs.length,
        itemBuilder: (context, index) {
          final job = jobProvider.jobs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          job.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\$${NumberFormat('#,###').format(job.budget)}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16),
                      const SizedBox(width: 4),
                      Text(job.location),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${DateFormat('MMM d').format(job.startDate)} - ${DateFormat('MMM d, y').format(job.endDate)}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  Text(
                    job.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: job.requirements.map((req) {
                      return Chip(
                        label: Text(
                          req,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _applyForJob(job.id);
                      },
                      child: const Text('APPLY NOW'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModelsList() {
    // Mock models list for brand owners
    final mockModels = [
      {'name': 'Sarah Johnson', 'location': 'New York, NY', 'height': '5\'9"'},
      {'name': 'Emily Davis', 'location': 'Los Angeles, CA', 'height': '5\'10"'},
      {'name': 'Jessica Wilson', 'location': 'Miami, FL', 'height': '5\'8"'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockModels.length,
      itemBuilder: (context, index) {
        final model = mockModels[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                model['name']![0],
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              model['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14),
                    const SizedBox(width: 4),
                    Text(model['location']!),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.height, size: 14),
                    const SizedBox(width: 4),
                    Text('Height: ${model['height']}'),
                  ],
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Viewing ${model['name']}\'s profile')),
                );
              },
              child: const Text('View'),
            ),
          ),
        );
      },
    );
  }

  void _applyForJob(String jobId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apply for Job'),
        content: const Text('Are you sure you want to apply for this job?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Application submitted successfully!')),
              );
            },
            child: const Text('APPLY'),
          ),
        ],
      ),
    );
  }
}
