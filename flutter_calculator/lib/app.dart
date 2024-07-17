import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/home_page/bloc/list_item/home_page_list_item_bloc.dart';
import 'package:flutter_calculator/home_page/bloc/total_price/home_page_total_price_bloc.dart';
import 'package:flutter_calculator/home_page/view/home_page.dart';
import 'package:flutter_calculator/home_page/bloc/home_page_list_bloc.dart';
import 'package:flutter_calculator/home_page/model/home_page_repository.dart';
import 'package:flutter_calculator/storage/a_storage.dart';
import 'package:flutter_calculator/storage/hive_storage.dart';
import 'package:flutter_calculator/storage/storage_key.dart' as storage_key;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Calculator',
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<HomePageRepository>(
            create: (context) => HomePageRepository()),
          RepositoryProvider<AStorage>(
            create: (context) => HiveStorage(
              storage_key.calculatorKey
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomePageListBloc>(
              create: (context) => HomePageListBloc(
                  RepositoryProvider.of<HomePageRepository>(context),
                  RepositoryProvider.of<AStorage>(context))
            ),

            BlocProvider<HomePageListItemBloc>(
              create: (context) => HomePageListItemBloc(
                  RepositoryProvider.of<HomePageRepository>(context)),
            ),

            BlocProvider<HomePageTotalPriceBloc>(
              create: (context) => HomePageTotalPriceBloc(
                  RepositoryProvider.of<HomePageRepository>(context), 0),
            ),
          ],
          child: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }

}
