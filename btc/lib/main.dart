import 'package:btc/theme/app_theme.dart';
import 'package:btc/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';

// If firebase_options.dart is not generated yet, user needs to run flutterfire configure.
// For now, I will use a dummy initialization or standard one, assuming user has set it up or I'll handle the error or add a comment.
// Getting firebase_options is tricky without running `flutterfire configure`.
// I'll assume standard init but without options for now or simple init. 
// Actually, I can't import firebase_options unless I create it or user does. 
// I'll just use Firebase.initializeApp() and let the user know they need configuration.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We need to initialize Firebase. 
  // Since we don't have the google-services.json or GoogleService-Info.plist in the environment yet, 
  // this might fail at runtime if not configured, but I need to add the code.
  // I'll try-catch it to avoid crashing if config is missing during my development/verification if I were running it (though I am not running it).
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // Use debugPrint instead of print for better practice in non-production logging
    debugPrint("Firebase initialization failed: $e");
    // Continue running app even if firebase fails, just to show UI
  }
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Beat The Competition',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: goRouter,
    );
  }
}
