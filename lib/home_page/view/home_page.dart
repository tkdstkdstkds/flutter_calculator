import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/home_page/bloc/home_page_list_bloc.dart';
import 'package:flutter_calculator/home_page/bloc/list_item/home_page_list_item_bloc.dart';
import 'package:flutter_calculator/home_page/bloc/total_price/home_page_total_price_bloc.dart';
import 'package:flutter_calculator/home_page/model/home_page_repository.dart';
import 'package:flutter_calculator/input_formatter/leading_zero_formatter.dart';

part 'home_page_list_item_row.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomePageListBloc>().add(const HomePageListFetchDataEvent());
    });

    return Scaffold(
        body: Column(
          children: <Widget>[
            ListTile(title: createFieldRow(context)),

            // seperator
            const Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.black,
            ),

            const SizedBox(height: 5),

            // Note: make sure list view have limited height, or will throw assertion error:
            //       Vertical viewport was given unbounded height.
            createListView(context),

            createFlushDataWidget(context),
          ],
        ),
        bottomNavigationBar: createBottomBar(context));
  }

  Widget createListView(BuildContext context) {
    return BlocBuilder<HomePageListBloc, HomePageListState>(
      builder: (_, state) {
        switch (state) {
          case HomePageListInitialState _:
          case HomePageListFetchingDataState _:
            return const SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator());

          case HomePageListFetchDataErrorState _:
            return Text(state.errorMessage);

          default:
            return Expanded(
                child: ReorderableListView.builder(
              buildDefaultDragHandles: false,
              itemCount: context.read<HomePageRepository>().getListItemCount(),
              itemBuilder: (context, index) {
                return ListTile(
                    key: Key('$index'),
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_handle),
                    ),
                    tileColor: index.isEven ? Colors.grey[200] : Colors.white,
                    // Note: pass bloc to child widget
                    title: BlocProvider.value(
                      value: context.read<HomePageListItemBloc>(),
                      child: createTextFieldRow(context, index),
                    ));
              },
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                context
                    .read<HomePageListBloc>()
                    .add(HomePageListMoveItemEvent(oldIndex, newIndex));
              },
              proxyDecorator: proxyDecorator,
            ));
        }
      },
    );
  }

  Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(1, 6, animValue)!;
          final double scale = lerpDouble(1, 1.05, animValue)!;
          return Transform.scale(
            scale: scale,
            // Create a Card based on the color and the content of the dragged one
            // and set its elevation to the animated value.
            child: Card(
              
              elevation: elevation,
              shadowColor: Colors.blueGrey,
              child: child,
            ),
          );
        },
        child: child,
      );
    }

  Widget createBottomBar(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomePageListBloc, HomePageListState>(
            listener: (context, state) {
              context
                  .read<HomePageTotalPriceBloc>()
                  .add(HomePageTotalPriceUpdateEvent());
            },
          ),
          BlocListener<HomePageListItemBloc, HomePageListItemState>(
            listener: (context, state) {
              context
                  .read<HomePageTotalPriceBloc>()
                  .add(HomePageTotalPriceUpdateEvent());
            },
          ),
        ],
        child: BottomAppBar(
          //shape: const Border(top: BorderSide(width: 1.0, color: Colors.black)),
          child: SizedBox(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      const Text(
                        '總價: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocBuilder<HomePageTotalPriceBloc,
                          HomePageTotalPriceState>(
                        builder: (context, state) {
                          return Text(
                            state.totalPrice.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => context
                        .read<HomePageListBloc>()
                        .add(const HomePageListAddItemEvent()),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget createFlushDataWidget(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomePageListBloc, HomePageListState>(
          listener: (context, state) {
            context
                .read<HomePageListBloc>()
                .add(const HomePageFlushDataEvent());
          },
        ),
        BlocListener<HomePageListItemBloc, HomePageListItemState>(
          listener: (context, state) {
            context
                .read<HomePageListBloc>()
                .add(const HomePageFlushDataEvent());
          },
        ),
      ],
      child: const SizedBox.shrink(),
    );
  }
}
