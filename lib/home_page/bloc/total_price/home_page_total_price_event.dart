part of 'home_page_total_price_bloc.dart';

sealed class HomePageTotalPriceEvent {
  const HomePageTotalPriceEvent();
}

class HomePageTotalPriceUpdateEvent extends HomePageTotalPriceEvent {

  HomePageTotalPriceUpdateEvent();
}