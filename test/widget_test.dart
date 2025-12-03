import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:castiq/main.dart';
import 'package:castiq/providers/auth_provider.dart';
import 'package:castiq/providers/portfolio_provider.dart';
import 'package:castiq/providers/job_provider.dart';
import 'package:castiq/screens/auth/welcome_screen.dart';

void main() {
  testWidgets('App initializes with WelcomeScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CastiqApp());

    // Verify that WelcomeScreen is displayed
    expect(find.text('CASTIQ'), findsOneWidget);
    expect(find.text('Professional Marketplace for Models'), findsOneWidget);
    expect(find.text('CONTINUE AS MODEL'), findsOneWidget);
    expect(find.text('CONTINUE AS BRAND OWNER'), findsOneWidget);
  });

  testWidgets('WelcomeScreen navigation buttons work', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PortfolioProvider()),
          ChangeNotifierProvider(create: (_) => JobProvider()),
        ],
        child: const MaterialApp(
          home: WelcomeScreen(),
        ),
      ),
    );

    // Find and tap the model button
    final modelButton = find.text('CONTINUE AS MODEL');
    expect(modelButton, findsOneWidget);
    
    await tester.tap(modelButton);
    await tester.pumpAndSettle();

    // Verify navigation to login screen
    expect(find.text('Model Login'), findsOneWidget);
  });

  testWidgets('Theme is properly applied', (WidgetTester tester) async {
    await tester.pumpWidget(const CastiqApp());

    // Get the MaterialApp
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    
    // Verify theme colors
    expect(app.theme?.primaryColor, const Color(0xFF000000)); // Black
    expect(app.theme?.scaffoldBackgroundColor, const Color(0xFFFFFFFF)); // White
  });
}
