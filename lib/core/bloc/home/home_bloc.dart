import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vpn_basic_project/core/repository/repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<NavigateToChangeVpnScreenEvent>(navigateToChangeVpnScreenEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      await Repository.getVpnData();
      emit(HomeLoadingSuccessState());
    } catch (e) {
      log(e.toString());
      emit(HomeErrorState());
      rethrow;
    }
  }

  FutureOr<void> navigateToChangeVpnScreenEvent(NavigateToChangeVpnScreenEvent event, Emitter<HomeState> emit) {
    print("Navigate to ChangeVpn");
    emit(NavigateToChangeVpnPageState());
  }
}
