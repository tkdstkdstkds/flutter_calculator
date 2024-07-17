part of 'home_page_list_item_bloc.dart';

sealed class HomePageListItemEvent {
  const HomePageListItemEvent();

}

final class HomePageListItemNameChangeEvent extends HomePageListItemEvent {
  final int listItemIndex;
  final String newName;
  const HomePageListItemNameChangeEvent(this.listItemIndex, this.newName);
}

final class HomePageListItemSinglePriceChangeEvent extends HomePageListItemEvent {
  final int listItemIndex;
  final double newSinglePrice;
  const HomePageListItemSinglePriceChangeEvent(this.listItemIndex, this.newSinglePrice);
}

final class HomePageListItemCountChangeEvent extends HomePageListItemEvent {
  final int listItemIndex;
  final int newCount;
  const HomePageListItemCountChangeEvent(this.listItemIndex, this.newCount);

}


