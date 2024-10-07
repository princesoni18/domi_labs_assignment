import 'package:domi_labs/features/home/bloc/home_bloc.dart';
import 'package:domi_labs/models/adress_model.dart';
import 'package:domi_labs/widgets/customButton.dart';
import 'package:domi_labs/widgets/customTextField.dart';
import 'package:domi_labs/widgets/custom_tile.dart';
import 'package:domi_labs/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:latlong2/latlong.dart';

class AdressCard extends StatefulWidget {
  final String count;
  final String title;
  final double height;
  const AdressCard(
      {super.key,
      required this.count,
      required this.title,
      required this.height});

  @override
  State<AdressCard> createState() => _AdressCardState();
}

class _AdressCardState extends State<AdressCard> {
  final TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController();
  int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    final bloc = BlocProvider.of<HomeBloc>(context, listen: true);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: widget.height,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: colorSchema.surface, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (pageNo != 1) {
                    print("TApped");
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 450),
                        curve: Curves.easeInOut);
                    bloc.add(LoadAddressEvent(
                        point: const LatLng(27.967533, -82.455235)));
                  } else {
                    searchController.clear();
                    bloc.add(RemoveLoadedAddresses());
                  }
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: colorSchema.inverseSurface,
                ),
              ),
              Text(
                "${pageNo.toString()}/4",
                style: TextStyle(color: colorSchema.inverseSurface),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Expanded(
            child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (value) {
                  pageNo = value + 1;
                  setState(() {});
                },
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              color: colorSchema.inverseSurface,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Open mails and earn money.",
                          style: TextStyle(
                              color: colorSchema.tertiary, fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Complete Address",
                          style: TextStyle(color: colorSchema.inverseSurface),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        BlocBuilder<HomeBloc, HomeState>(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is HomeInitial ||
                                state is AddressLoadedState) {
                              return CustomTextField(
                                controller: searchController,
                                labelText: "4a building",
                                icon: Image.asset("assets/place.png"),
                                suffixIcon: GestureDetector(
                                  onTap: ()=>bloc.add(LoadAddressEvent(
                                      point:
                                          const LatLng(27.967533, -82.455235))),
                                  child: Image.asset("assets/gps.png")),
                                onSubmit: (value) {
                                  bloc.add(LoadAddressEvent(
                                      point:
                                          const LatLng(27.967533, -82.455235)));
                                },
                              );
                            }

                            return Container();
                          },
                        ),
                        BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is SelectedAddressState) {
                              final address = bloc.selectedAddress!;

                              return CustomTile(
                                title: address.street,
                                subTitle: "${address.landmark},${address.city}",
                                prefix: Image.asset("assets/place.png"),
                                suffix: null,
                              );
                            }
                            if (state is AddressLoadedState) {
                              List<AddressModel> address = bloc.addresses;
                              return Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: address.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () => bloc.add(SelectAddressEvent(
                                        address: address[index])),
                                    child: CustomTile(
                                      title: address[index].street,
                                      subTitle:
                                          "${address[index].landmark},${address[index].city}",
                                      prefix: Image.asset("assets/place.png"),
                                      suffix: null,
                                    ),
                                  )
                                          .animate()
                                          .fadeIn(
                                              duration: const Duration(
                                                  milliseconds: 300))
                                          .slideY(
                                              begin: -1,
                                              duration: const Duration(
                                                  milliseconds: 300)),
                                ),
                              );
                            }

                            return const SizedBox(
                              height: 20,
                            );
                          },
                        ),
                      ]),
                  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          "Earn with your Domi ID",
                          style: TextStyle(
                              color: colorSchema.inverseSurface,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Open mails and earn money.",
                          style: TextStyle(
                              color: colorSchema.tertiary, fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "your Home Value: \$2.76M (Est.)",
                          style: TextStyle(color: colorSchema.inverseSurface),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        CustomSlider(height: 65.h, width: 320.w),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Opening ${(bloc.value * 60).toInt()} direct digital mails.",
                          style: TextStyle(
                              color: colorSchema.primary, fontSize: 12.sp),
                        ),
                      ])
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 450)),
                ]),
          ),
          Align(
              alignment: Alignment.center,
              child: Custombutton(
                  onTap: () {
                    if (bloc.state is SelectedAddressState) {
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 450),
                          curve: Curves.easeInOut);
                      bloc.add(CalculateValuationEvent(value: 0.45));
                    }
                  },
                  color: bloc.selectedAddress != null
                      ? colorSchema.primary
                      : colorSchema.tertiary,
                  title: "Claim This Address",
                  height: 48.h,
                  width: 320.w))
        ],
      ),
    );
  }
}
