import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/l10n/l10n.dart';
import 'package:carrypill/presentations/pages/homepage/homepage.dart';
import 'package:carrypill/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kprimarySwatch,
      ),
      supportedLocales: L10n.supportedLocales,
       localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
