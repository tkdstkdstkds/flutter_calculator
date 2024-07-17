part of 'home_page_list_bloc.dart';

sealed class HomePageListState{
  const HomePageListState();
}

final class HomePageListInitialState extends HomePageListState {

}

final class HomePageListFetchingDataState extends HomePageListState {
  const HomePageListFetchingDataState();
}

final class HomePageListFetchDataErrorState extends HomePageListState {
  final String errorMessage;
  const HomePageListFetchDataErrorState(this.errorMessage);
}

final class HomePageListFetchDataSuccessState extends HomePageListState {
  final List<HomePageListItemModel> listItemModels;
  const HomePageListFetchDataSuccessState(this.listItemModels);
}


final class HomePageListAddItemState extends HomePageListState {
  final HomePageListItemModel addItemModel;
  const HomePageListAddItemState(this.addItemModel);
}

final class HomePageListRemoveItemState extends HomePageListState {
  final HomePageListItemModel removeItemModel;
  const HomePageListRemoveItemState(this.removeItemModel);
}

final class HomePageListMoveItemState extends HomePageListState {
  final int fromIndex;
  final int toIndex;
  const HomePageListMoveItemState(this.fromIndex, this.toIndex);
}
