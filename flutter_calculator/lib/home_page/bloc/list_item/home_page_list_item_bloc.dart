import 'package:bloc/bloc.dart';
import 'package:flutter_calculator/home_page/model/home_page_repository.dart';

part 'home_page_list_item_event.dart';
part 'home_page_list_item_state.dart';

class HomePageListItemBloc
    extends Bloc<HomePageListItemEvent, HomePageListItemState> {
 HomePageRepository homePageRespository;


  HomePageListItemBloc(this.homePageRespository) : super(HomePageListItemInitialState()) {
    on<HomePageListItemNameChangeEvent>(
        (event, emit) => onHomePageListItemNameChangeEvent(event, emit));
    on<HomePageListItemSinglePriceChangeEvent>(
        (event, emit) => onHomePageListItemSinglePriceChangeEvent(event, emit));
    on<HomePageListItemCountChangeEvent>(
        (event, emit) => onHomePageListItemCountChangeEvent(event, emit));
  }

  void onHomePageListItemNameChangeEvent(
      HomePageListItemNameChangeEvent event, Emitter<HomePageListItemState> emit) {
    var updatedItemModel = homePageRespository.getListItem(event.listItemIndex);
    updatedItemModel.itemName = event.newName;

    emit(HomePageListItemUpdateState(updatedItemModel));
  }

  void onHomePageListItemSinglePriceChangeEvent(
      HomePageListItemSinglePriceChangeEvent event, Emitter<HomePageListItemState> emit) {
    var updatedItemModel = homePageRespository.getListItem(event.listItemIndex);
    updatedItemModel.itemSinglePrice = event.newSinglePrice;
    updatedItemModel.itemTotalPrice = calculateItemTotalPrice(updatedItemModel);

    emit(HomePageListItemUpdateState(updatedItemModel));
  }

  void onHomePageListItemCountChangeEvent(
      HomePageListItemCountChangeEvent event, Emitter<HomePageListItemState> emit) {
    var updatedItemModel = homePageRespository.getListItem(event.listItemIndex);
    updatedItemModel.itemCount = event.newCount;
    updatedItemModel.itemTotalPrice = calculateItemTotalPrice(updatedItemModel);

    emit(HomePageListItemUpdateState(updatedItemModel));
  }

  double calculateItemTotalPrice(HomePageListItemModel itemModel) {
    return itemModel.itemSinglePrice * itemModel.itemCount;
  }
}
