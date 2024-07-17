part of 'home_page_list_bloc.dart';

sealed class HomePageListEvent {
  const HomePageListEvent();
}

final class HomePageListFetchDataEvent extends HomePageListEvent {
  const HomePageListFetchDataEvent();
}

final class HomePageListAddItemEvent extends HomePageListEvent {
  const HomePageListAddItemEvent();
}

final class HomePageListRemoveItemEvent extends HomePageListEvent {
  final int index;
  const HomePageListRemoveItemEvent(this.index);
}

final class HomePageListMoveItemEvent extends HomePageListEvent {
  final int fromIndex;
  final int toIndex;
  const HomePageListMoveItemEvent(this.fromIndex, this.toIndex);
}

final class HomePageFlushDataEvent extends HomePageListEvent {
  const HomePageFlushDataEvent();
}