import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/portfolio_provider.dart';
import 'providers/job_provider.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/payment/payment_screen.dart';

void main() {
  runApp(const CastiqApp());
}

class CastiqApp extends StatelessWidget {
  const CastiqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PortfolioProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
      ],
      child: MaterialApp(
        title: 'Castiq',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const WelcomeScreen(),
        routes: {
          '/payment': (context) => const PaymentScreen(),
        },
      ),
    );
  }
}
