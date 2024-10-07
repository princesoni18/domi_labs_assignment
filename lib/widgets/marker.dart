import 'package:domi_labs/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context, listen: true);
    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            bloc: bloc,
                  builder: (context, state) {
                    
                    if(state is SelectedAddressState){
                    return Positioned(
                        top: -30,
                        child: Container(
                          height: 30.h,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            bloc.selectedAddress!.street +
                                bloc.selectedAddress!.city,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ));}

                        else if(state is ValuationOfAddressState){
                          
                           return Positioned(
                        top: -60,
                        child: Container(
                          height: 30.h,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            bloc.selectedAddress!.street +
                                bloc.selectedAddress!.city,
                            style: const  TextStyle(color: Colors.white),
                          )));

                        }


                        return Container();
                  },
                ),


                BlocBuilder<HomeBloc,HomeState>(

                  bloc: bloc,
                  builder: (context, state) {
                  
                  if(state is ValuationOfAddressState){

                    return Positioned(
                      top: -10,
                      child: Container(
                         height: 30.h,
                         width: 100,
                         alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                      
                      
                                child:  Text("\$${(bloc.value * 300).round()}/mo",style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  }

                  return SizedBox();
                },)
             ,
          Image.asset(
            "assets/pin.png",
            height: 20,
          )
        ],
      ),
    );
  }
}
