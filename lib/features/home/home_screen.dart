import 'dart:math';

import 'package:domi_labs/features/home/bloc/home_bloc.dart';
import 'package:domi_labs/utils/themes/bloc/theme_bloc.dart';
import 'package:domi_labs/utils/themes/light_theme.dart';
import 'package:domi_labs/widgets/adress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    final bloc = BlocProvider.of<ThemeBloc>(context, listen: true);
    final homeBloc = BlocProvider.of<HomeBloc>(context, listen: true);
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) => current is ActionState,
      listener: (context, state) {
        if (state is CompletedState) {}
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/temp_bg.jpg"),
                          fit: BoxFit.cover)),
                  child: FlutterMap(
                    options: MapOptions(
                        interactionOptions: const InteractionOptions(
                            flags:
                                InteractiveFlag.all & ~InteractiveFlag.rotate),
                        initialZoom: 11.0,
                        initialCenter: const LatLng(27.967533, -82.455235),
                        initialRotation: 0.0,
                        onTap: (tapPosition, point) {
                          print(point);
                          if (homeBloc.state is! ValuationOfAddressState) {
                            homeBloc.add(LoadAddressEvent(
                              point: point,
                            ));
                          } // Adds marker where user taps
                        }),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}.png?api_key=b5a2406a-cd62-4c0c-9906-8f918ff20994',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(rotate: false, markers: homeBloc.markers)
                    ],
                  )),
              Positioned(
                  right: 10,
                  top: 40.h,
                  child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.6),
                      radius: 22.sp,
                      child: InkWell(
                          onTap: () => bloc.add(ToggleTheme()),
                          child: bloc.themeData == light_theme
                              ? Icon(
                                  Icons.sunny,
                                  color: colorSchema.surface,
                                )
                              : Icon(Icons.nightlight_outlined,
                                  color: colorSchema.surface)))),
              BlocBuilder<HomeBloc, HomeState>(
                  bloc: homeBloc,
                  builder: (context, state) {
                    double height = 320.h;
                    if (state is AddressLoadedState) {
                      height = 500.h;
                    }
                    if (State is SelectedAddressState) {
                      height = 400.h;
                    }
                    if (state is ValuationOfAddressState) {
                      height = 350.h;
                    }

                    return Positioned(
                            bottom: max(
                                20.h, MediaQuery.of(context).viewInsets.bottom),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    child: AdressCard(
                                        height: height,
                                        count: "1",
                                        title: "Claim your Domi ID"))))
                        .animate()
                        .slideY(
                            begin: 2,
                            duration: const Duration(milliseconds: 600))
                        .fadeIn(duration: const Duration(milliseconds: 1000));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
