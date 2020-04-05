import 'package:admin_app/components/theme.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/screens/admin.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: notifier.isDark ? dark : light,
          home: Admin(),
        );
      }),
    );
  }
}
