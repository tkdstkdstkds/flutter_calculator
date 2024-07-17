part of 'home_page_list_item_bloc.dart';

sealed class HomePageListItemState{
  const HomePageListItemState();

}

final class HomePageListItemInitialState extends HomePageListItemState {}

final class HomePageListItemUpdateState extends HomePageListItemState {
  final HomePageListItemModel updatedItemModel;
  const HomePageListItemUpdateState(this.updatedItemModel);
}
