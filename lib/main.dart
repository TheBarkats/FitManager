import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const FitManagerApp());
}

class FitManagerApp extends StatelessWidget {
  const FitManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitManager',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
