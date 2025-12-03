import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';
import 'auth/welcome_screen.dart';
import 'profile/id_verification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final isModel = user?.userType == UserType.model;

    if (user == null) {
      return const Center(child: Text('No user data'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Open settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                user.name[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            Text(
              user.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            
            Text(
              user.email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            
            // Verification Status
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  user.isVerified ? Icons.verified : Icons.warning_outlined,
                  color: user.isVerified ? Colors.green : Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  user.isVerified ? 'Verified' : 'Not Verified',
                  style: TextStyle(
                    color: user.isVerified ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Profile Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  if (!user.isVerified)
                    Card(
                      color: Colors.orange.withOpacity(0.1),
                      child: ListTile(
                        leading: const Icon(Icons.verified_user, color: Colors.orange),
                        title: const Text('Verify Your Identity'),
                        subtitle: const Text('Complete verification to access all features'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IdVerificationScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  
                  const SizedBox(height: 8),
                  
                  _buildProfileOption(
                    context,
                    Icons.person_outline,
                    'Edit Profile',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit profile coming soon')),
                      );
                    },
                  ),
                  
                  _buildProfileOption(
                    context,
                    Icons.account_balance_wallet_outlined,
                    'Payment Methods',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Payment methods coming soon')),
                      );
                    },
                  ),
                  
                  if (isModel)
                    _buildProfileOption(
                      context,
                      Icons.receipt_long_outlined,
                      'Earnings',
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Earnings coming soon')),
                        );
                      },
                    ),
                  
                  _buildProfileOption(
                    context,
                    Icons.history,
                    'Activity History',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Activity history coming soon')),
                      );
                    },
                  ),
                  
                  _buildProfileOption(
                    context,
                    Icons.help_outline,
                    'Help & Support',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Help & support coming soon')),
                      );
                    },
                  ),
                  
                  _buildProfileOption(
                    context,
                    Icons.privacy_tip_outlined,
                    'Privacy Policy',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Privacy policy coming soon')),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('CANCEL'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('LOGOUT'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true && context.mounted) {
                          await authProvider.logout();
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WelcomeScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('LOGOUT'),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
