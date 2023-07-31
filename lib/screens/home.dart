import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/core/bloc/home/home_bloc.dart';
import 'package:vpn_basic_project/core/constant/color_constant.dart';
import 'package:vpn_basic_project/core/constant/textstyle_constant.dart';
import 'package:vpn_basic_project/screens/change_vpn_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is NavigateToChangeVpnPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeVpnScreen()));
        }
      },
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator(color: ColorConstant.primaryColor)));
          case HomeLoadingSuccessState:
            return Scaffold(
              backgroundColor: ColorConstant.bgColor,
              appBar: AppBar(
                title: Text("VPN", style: TextStyleConstant.bStyle16.copyWith(fontWeight: FontWeight.w600)),
                centerTitle: true,
                backgroundColor: ColorConstant.bgColor,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    selectServer(),
                    connectButton(),
                  ],
                ),
              ),
            );
          case HomeErrorState:
            return Scaffold(body: Text('Error'));
          default:
            return SizedBox();
        }
      },
    );
  }

  Widget selectServer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [BoxShadow(color: ColorConstant.black.withOpacity(0.1), blurRadius: 20, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorConstant.grey,
            radius: 25,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Country Name", style: TextStyleConstant.bStyle14),
              Text("City Name", style: TextStyleConstant.gStyle12.copyWith(fontWeight: FontWeight.w400)),
            ],
          ),
          Spacer(),
          GestureDetector(
              onTap: () {
                homeBloc.add(NavigateToChangeVpnScreenEvent());
              },
              child: Text("Change", style: TextStyleConstant.gStyle12.copyWith(fontWeight: FontWeight.w400, color: ColorConstant.primaryColor))),
          Icon(Icons.keyboard_arrow_right_rounded, color: ColorConstant.grey)
        ],
      ),
    );
  }

  Widget connectButton() {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/home_screen.json',
            animate: true,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2, left: 5),
            child: CircleAvatar(
              backgroundColor: ColorConstant.primaryColor,
              radius: 30,
              child: Icon(Icons.power_settings_new_rounded, color: ColorConstant.white),
            ),
          ),
        ],
      ),
    );
  }
}
