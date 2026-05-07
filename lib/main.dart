import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/services/locale_provider.dart';
import 'core/services/app_router.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MaktomApp());
}

class MaktomApp extends StatelessWidget {
  const MaktomApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = sl<LocaleProvider>();

    return ListenableBuilder(
      listenable: localeProvider,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Maktom',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
        );
      },
    );
  }
}
