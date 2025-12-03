enum JobStatus { open, closed, inProgress }

class Job {
  final String id;
  final String brandOwnerId;
  final String title;
  final String description;
  final String location;
  final double budget;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> requirements;
  final JobStatus status;
  final DateTime createdAt;

  Job({
    required this.id,
    required this.brandOwnerId,
    required this.title,
    required this.description,
    required this.location,
    required this.budget,
    required this.startDate,
    required this.endDate,
    required this.requirements,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandOwnerId': brandOwnerId,
      'title': title,
      'description': description,
      'location': location,
      'budget': budget,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'requirements': requirements,
      'status': status.toString(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      brandOwnerId: json['brandOwnerId'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      budget: json['budget'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      requirements: List<String>.from(json['requirements']),
      status: json['status'] == 'JobStatus.open'
          ? JobStatus.open
          : json['status'] == 'JobStatus.closed'
              ? JobStatus.closed
              : JobStatus.inProgress,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
