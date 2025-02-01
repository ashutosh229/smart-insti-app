import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_insti_app/constants/constants.dart';
import 'package:smart_insti_app/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initializing the binding
  // await dotenv.load();
  await dotenv.load(fileName: "../assets/.env"); //loading the env variables
  runApp(const ProviderScope(
      child: SmartInstiApp())); //running the app with providers
}

class SmartInstiApp extends StatelessWidget {
  const SmartInstiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.seedColor),
        useMaterial3: true,
      ),
      routerConfig: routes,
    );
  }
}
