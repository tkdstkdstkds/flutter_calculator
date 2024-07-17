import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculator/app.dart';
import 'package:flutter_calculator/home_page/model/home_page_repository.dart';


import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HomePageListModelAdapter());
  Hive.registerAdapter(HomePageListItemModelAdapter());

  // use full screen mode, without top status bar in android or ios
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const MyApp());
}




