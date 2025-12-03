import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<Map<String, dynamic>> _bookings = [
    {
      'modelName': 'Sarah Johnson',
      'jobTitle': 'Fashion Photoshoot',
      'date': DateTime.now().add(const Duration(days: 5)),
      'amount': 5000,
      'status': 'confirmed',
    },
    {
      'modelName': 'Emily Davis',
      'jobTitle': 'Commercial Shoot',
      'date': DateTime.now().add(const Duration(days: 12)),
      'amount': 3500,
      'status': 'pending',
    },
    {
      'modelName': 'Jessica Wilson',
      'jobTitle': 'Magazine Cover',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'amount': 4200,
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: _bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Bookings',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your bookings will appear here',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _bookings.length,
              itemBuilder: (context, index) {
                final booking = _bookings[index];
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking['jobTitle'],
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    booking['modelName'],
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            _buildStatusChip(booking['status']),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('MMM dd, yyyy').format(booking['date']),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        
                        Row(
                          children: [
                            const Icon(Icons.attach_money, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              '\$${NumberFormat('#,###').format(booking['amount'])}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        
                        if (booking['status'] == 'pending') ...[
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    _cancelBooking(index);
                                  },
                                  child: const Text('CANCEL'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _confirmBooking(index);
                                  },
                                  child: const Text('CONFIRM'),
                                ),
                              ),
                            ],
                          ),
                        ],
                        
                        if (booking['status'] == 'confirmed') ...[
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Opening chat...')),
                                );
                              },
                              icon: const Icon(Icons.chat_outlined),
                              label: const Text('MESSAGE MODEL'),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String label;
    
    switch (status) {
      case 'confirmed':
        color = Colors.green;
        label = 'CONFIRMED';
        break;
      case 'pending':
        color = Colors.orange;
        label = 'PENDING';
        break;
      case 'completed':
        color = Colors.blue;
        label = 'COMPLETED';
        break;
      default:
        color = Colors.grey;
        label = 'UNKNOWN';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _confirmBooking(int index) {
    setState(() {
      _bookings[index]['status'] = 'confirmed';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking confirmed!')),
    );
  }

  void _cancelBooking(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('NO'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _bookings.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking cancelled')),
              );
            },
            child: const Text('YES'),
          ),
        ],
      ),
    );
  }
}
