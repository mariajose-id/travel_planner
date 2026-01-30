import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_planner/core/di/service_locator.dart';
import 'package:travel_planner/core/router/app_router.dart';
import 'package:travel_planner/core/logging/logger.dart';
import 'package:travel_planner/features/auth/models/user.dart';
import 'package:travel_planner/features/trips/data/models/trip_model.dart';
import 'package:travel_planner/features/trips/data/repositories/trip_repository_impl.dart';
import 'package:travel_planner/core/providers/language_provider.dart';
import 'package:travel_planner/core/providers/theme_provider.dart';
import 'package:travel_planner/core/constants/app_constants.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  
  AppLogger.initialize(
    level: kDebugMode ? LogLevel.debug : LogLevel.info,
    enableFileLogging: !kDebugMode, 
    logDirectory: '/tmp/travel_planner_logs',
  );
  
  
  await Hive.initFlutter();
  
  await setupServiceLocator();
  
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TripModelAdapter());
  
  await Hive.openBox('auth');
  await Hive.openBox('users');
  final Box<TripModel> tripsBox = await Hive.openBox<TripModel>('trips');
  
  final tripRepository = TripRepositoryImpl(tripsBox: tripsBox);
  await tripRepository.initialize();
  
  
  final languageProvider = LanguageProvider();
  await languageProvider.loadLanguage();
  
  
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: languageProvider),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, languageProvider, themeProvider, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: languageProvider.supportedLocales,
          locale: languageProvider.currentLocale,
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
          routerConfig: appRouter,
        );
      },
    );
  }
}
