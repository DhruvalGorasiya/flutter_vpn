import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_vpn_event.dart';

part 'change_vpn_state.dart';

class ChangeVpnBloc extends Bloc<ChangeVpnEvent, ChangeVpnState> {
  ChangeVpnBloc() : super(ChangeVpnInitial()) {
    on<ChangeVpnEvent>((event, emit) {});
  }
}
