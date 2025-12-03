import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/auth_provider.dart';
import 'matchmaker/matchmaker_screen.dart';
import 'portfolio/portfolio_screen.dart';
import 'chat/chat_screen.dart';
import 'booking/booking_screen.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isModel = authProvider.currentUser?.userType == UserType.model;

    final List<Widget> screens = isModel
        ? [
            const DashboardScreen(),
            const MatchmakerScreen(),
            const PortfolioScreen(),
            const ChatScreen(),
            const ProfileScreen(),
          ]
        : [
            const DashboardScreen(),
            const MatchmakerScreen(),
            const BookingScreen(),
            const ChatScreen(),
            const ProfileScreen(),
          ];

    final List<BottomNavigationBarItem> navItems = isModel
        ? const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              activeIcon: Icon(Icons.work),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library_outlined),
              activeIcon: Icon(Icons.photo_library),
              label: 'Portfolio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]
        : const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search),
              label: 'Find Models',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_outlined),
              activeIcon: Icon(Icons.event),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: navItems,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isModel = authProvider.currentUser?.userType == UserType.model;
    final userName = authProvider.currentUser?.name ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('CASTIQ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                userName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              
              if (isModel) ...[
                // Model-specific dashboard
                _buildStatCard(
                  context,
                  'Profile Views',
                  '1,234',
                  Icons.visibility_outlined,
                  Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  context,
                  'Active Applications',
                  '5',
                  Icons.send_outlined,
                  Colors.orange,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  context,
                  'Completed Jobs',
                  '12',
                  Icons.check_circle_outline,
                  Colors.green,
                ),
              ] else ...[
                // Brand owner-specific dashboard
                _buildStatCard(
                  context,
                  'Active Jobs',
                  '3',
                  Icons.work_outline,
                  Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  context,
                  'Applications Received',
                  '28',
                  Icons.mail_outline,
                  Colors.orange,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  context,
                  'Upcoming Bookings',
                  '2',
                  Icons.event_outlined,
                  Colors.green,
                ),
              ],
              
              const SizedBox(height: 24),
              
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              if (isModel)
                _buildQuickActionButton(
                  context,
                  'Boost Profile',
                  Icons.rocket_launch,
                  () {
                    Navigator.pushNamed(context, '/payment');
                  },
                )
              else
                _buildQuickActionButton(
                  context,
                  'Post New Job',
                  Icons.add_circle_outline,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon: Post new job')),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
