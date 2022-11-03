import 'package:carrypill/business_logic/provider/order_provider.dart';
import 'package:carrypill/business_logic/provider/patient_provider.dart';
import 'package:carrypill/business_logic/provider/provider_location.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/models/rider.dart';
import 'package:carrypill/data/repositories/firebase_repo/auth_repo.dart';
import 'package:carrypill/data/repositories/map_repo/location_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'constants/constant_color.dart';
import 'l10n/l10n.dart';
import 'presentations/pages/homepage/homepage.dart';
import 'route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Position? position = await LocationRepo().initPosition();
  // print(position);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProviderLocation>.value(
      value: ProviderLocation(position: position),
    ),
    StreamProvider<PatientUid?>.value(
      catchError: (_, __) => null,
      value: AuthRepo().patient,
      initialData: null,
    ),
    ChangeNotifierProvider<PatientProvider?>(
      create: (_) => PatientProvider(),
    ),
    ChangeNotifierProvider<OrderProvider?>(
      create: (_) => OrderProvider(orderService: OrderService()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: kcprimarySwatch,
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
        });
  }
}
