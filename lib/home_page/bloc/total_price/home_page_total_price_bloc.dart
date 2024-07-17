import 'package:bloc/bloc.dart';
import 'package:flutter_calculator/home_page/model/home_page_repository.dart';

part 'home_page_total_price_event.dart';
part 'home_page_total_price_state.dart';

class HomePageTotalPriceBloc extends Bloc<HomePageTotalPriceEvent, HomePageTotalPriceState> {
  HomePageRepository homePageRespository;
  
  HomePageTotalPriceBloc(this.homePageRespository, double initialPrice) : super(HomePageTotalPriceInitialState(initialPrice)) {
    on<HomePageTotalPriceEvent>((event, emit) {
      emit(HomePageTotalPriceUpdateState(calculateTotalPrice()));
    });
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var element in homePageRespository.getListItems()) {
      totalPrice += element.itemTotalPrice;
    }
    return totalPrice;
  }
  
}
