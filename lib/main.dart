import 'dart:io';

import 'package:coronavirus_rest_api_flutter_course/app/repositories/data_repository.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_service.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/data_cache_service.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // nécessaire pour accéder à SharePreferences
  final sharedPref = await SharedPreferences.getInstance(); // singleton

  Intl.defaultLocale = Platform.localeName; //'fr_FR';
  print('Intl.defaultLocale = ${Intl.defaultLocale}');
  await initializeDateFormatting();
  runApp(MyApp(sharedPreferences: sharedPref));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
          apiService: APIService(API.sandbox()),
          dataCacheService:
              DataCacheService(sharedPreferences: sharedPreferences)),
      child: MaterialApp(
        title: 'Coronavirus Tracker',
        debugShowCheckedModeBanner: false, // pour enlever la banière "debug"
        theme: ThemeData.dark().copyWith(
          // Flutter gère le mode sombre
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
