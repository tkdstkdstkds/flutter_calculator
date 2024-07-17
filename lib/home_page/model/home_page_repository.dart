import 'dart:collection';
import 'package:flutter_calculator/storage/a_storage.dart';
import 'package:flutter_calculator/storage/hive_type_ids.dart';
import 'package:hive/hive.dart';

part 'home_page_repository.g.dart';

@HiveType(typeId: homePageListItemModelTypeId)
class HomePageListModel {
  HomePageListModel({
    required List<HomePageListItemModel> items,
  }) : _items = items;

  @HiveField(0)
  final List<HomePageListItemModel> _items;

  bool isEmpty() {
    return _items.isEmpty;
  }
}

@HiveType(typeId: homePageListModelTypeId)
class HomePageListItemModel{
  HomePageListItemModel({
    required this.itemName,
    required this.itemSinglePrice,
    required this.itemCount,
    required this.itemTotalPrice,
  });

  @HiveField(0)
  String itemName;

  @HiveField(1)
  double itemSinglePrice;

  @HiveField(2)
  int itemCount;

  @HiveField(3)
  double itemTotalPrice;

  HomePageListItemModel clone() {
    return HomePageListItemModel(
      itemName: itemName,
      itemSinglePrice: itemSinglePrice,
      itemCount: itemCount,
      itemTotalPrice: itemTotalPrice,
    );
  }

  @override
  String toString() {
    return 'HomePageListItemModel: $itemName, $itemSinglePrice, $itemCount, $itemTotalPrice';
  }
}

class HomePageRepository {

  HomePageListModel _listModel = HomePageListModel(items: []);

  HomePageListItemModel defaultListItemModel = HomePageListItemModel(
    itemName: '',
    itemSinglePrice: 0,
    itemCount: 0,
    itemTotalPrice: 0,
  );

  HomePageRepository();

  void setDefaultListItemModel(HomePageListItemModel item) {
    defaultListItemModel = item;
  }

  HomePageListItemModel cloneDefualtListItemModel() {
    return defaultListItemModel.clone();
  }

  void mergeListModel(HomePageListModel model) {
    for (HomePageListItemModel item in model._items) {
      addListItem(item);
    }
  }

  void setList(List<HomePageListItemModel> items) {
    _listModel = HomePageListModel(items: items);
  }

  void addListItem(HomePageListItemModel item) {
    _listModel._items.add(item);
  }

  HomePageListItemModel removeListItem(int index) {
    return _listModel._items.removeAt(index);
  }

  int getListItemCount() {
    return _listModel._items.length;
  }

  HomePageListItemModel getListItem(int index) {
    return _listModel._items[index];
  }

  UnmodifiableListView<HomePageListItemModel> getListItems() {
    return UnmodifiableListView(_listModel._items);
  }

  void moveListItem(int fromIndex, int toIndex) {
    HomePageListItemModel item = _listModel._items.removeAt(fromIndex);
    _listModel._items.insert(toIndex, item);
  }

  Future<void> saveListModel(AStorage storage, String key) async {
    await storage.put(key, value: _listModel);
  }

  void clear() async {
    _listModel._items.clear();
  }
}
