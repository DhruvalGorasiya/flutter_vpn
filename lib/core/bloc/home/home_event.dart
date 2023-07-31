part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class NavigateToChangeVpnScreenEvent extends HomeEvent {}

class ConnectVpnEvent extends HomeEvent {}
