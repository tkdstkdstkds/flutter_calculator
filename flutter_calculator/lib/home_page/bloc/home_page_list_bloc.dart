import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_calculator/home_page/model/home_page_repository.dart';
import 'package:flutter_calculator/storage/a_storage.dart';
import 'package:flutter_calculator/storage/storage_key.dart' as storage_key;

part 'home_page_list_event.dart';
part 'home_page_list_state.dart';

class HomePageListBloc extends Bloc<HomePageListEvent, HomePageListState> {
  HomePageRepository homePageRespository;
  AStorage homePageStorage;


  HomePageListBloc(this.homePageRespository, this.homePageStorage)
      : super(HomePageListInitialState()) {

    on<HomePageListEvent>(onHomePageListEvent, transformer: sequential());
  }

  Future<void> onHomePageListEvent(
      HomePageListEvent event, Emitter<HomePageListState> emit) async {
    switch(event) {
      case HomePageListFetchDataEvent event:
        await onHomePageListFetchDataEvent(event, emit);
        break;
      case HomePageListAddItemEvent event:
        await onHomePageListAddItemEvent(event, emit);
        break;
      case HomePageListRemoveItemEvent event:
        await onHomePageListRemoveItemEvent(event, emit);
        break;
      case HomePageListMoveItemEvent event:
        await onHomePageListMoveItemEvent(event, emit);
        break;
      case HomePageFlushDataEvent event:
        await onHomePageFlushDataEvent(event, emit);
        break;
    }
  }

  Future<void> onHomePageListFetchDataEvent(
      HomePageListFetchDataEvent event, Emitter<HomePageListState> emit) async {

    emit(const HomePageListFetchingDataState());

    // remove previous data, avoid hot reload keep old data
    homePageRespository.clear();

    print('onHomePageListFetchDataEvent');
    await homePageStorage.init();
    print('onHomePageListFetchDataEvent 1');
    HomePageListModel? loadedModel = await homePageStorage.get<HomePageListModel>(storage_key.homePageKey);
    if(loadedModel == null || loadedModel.isEmpty()) {
      List<HomePageListItemModel> items = [];
      for(int i = 0; i < 3; i++) {
        HomePageListItemModel itemModel = homePageRespository.cloneDefualtListItemModel();
        items.add(itemModel);
      }
      loadedModel = HomePageListModel(items: items);
    }
    homePageRespository.mergeListModel(loadedModel);
    print('onHomePageListFetchDataEvent 2');
    emit(HomePageListFetchDataSuccessState(homePageRespository.getListItems()));
}


  Future<void> onHomePageListAddItemEvent(
      HomePageListAddItemEvent event, Emitter<HomePageListState> emit) async {

    HomePageListItemModel newListItemModel = homePageRespository.cloneDefualtListItemModel();
    homePageRespository.addListItem(newListItemModel);
    
    emit(HomePageListAddItemState(newListItemModel));
  }

  Future<void> onHomePageListRemoveItemEvent(
      HomePageListRemoveItemEvent event, Emitter<HomePageListState> emit) async {
    HomePageListItemModel removeItem =
        homePageRespository.removeListItem(event.index);

    emit(HomePageListRemoveItemState(removeItem));
  }

  Future<void> onHomePageListMoveItemEvent(
      HomePageListMoveItemEvent event, Emitter<HomePageListState> emit) async {
    homePageRespository.moveListItem(event.fromIndex, event.toIndex);

    emit(HomePageListMoveItemState(event.fromIndex, event.toIndex));
  }

  Future<void> onHomePageFlushDataEvent(
      HomePageFlushDataEvent event, Emitter<HomePageListState> emit) async {
    await homePageRespository.saveListModel(homePageStorage, storage_key.homePageKey);
  }
}
