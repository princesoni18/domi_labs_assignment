import 'dart:math';

import 'package:domi_labs/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CustomSlider extends StatefulWidget {
  final double width;
  final double height;
  const CustomSlider({super.key, required this.height, required this.width});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0.45;
   bool _showTooltip = false;
  Offset _tooltipOffset = Offset.zero;
  

  @override
  Widget build(BuildContext context) {

    final homeBloc=BlocProvider.of<HomeBloc>(context,listen: false);
    return  Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth:widget.width,maxHeight: widget.height ),
          child: Container(
          
            
            height: widget.height,
            width: widget.width,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  left: 0,
                  
                  right: 0,
                  child: Container(
                    height: 56,
                     decoration: const BoxDecoration(
                      color: const Color(0xFFEBEBEB),
                      borderRadius: BorderRadius.only(
                       
                      ),
                    ),
                  )),
                Positioned(
                  left: 0,
                 
                  right: (1 - _value) * widget.width,
                  child: Container(
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD9FF00),
                      borderRadius: BorderRadius.only(
                      
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          '\$${(_value * 300).round()}/mo',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                 Positioned(
                  left: max(_value * widget.width - 10,0),
                  bottom:-10,
                 
                  child: Container(
                    width: 14,
                    height: 73,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: Container(color: const Color.fromARGB(255, 187, 184, 184),),
                  ),
                ),
          
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 56,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                    activeTrackColor:  Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                    
                   
                  ),
                  child: Slider(
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                           homeBloc.add(CalculateValuationEvent(value: value));
                         _showTooltip = true; // Show tooltip on interaction
                    // Calculate tooltip offset (adjust as needed)
                    _tooltipOffset = Offset(
                        value * (widget.width - 60) / 100 - 30, 
                        -40);
                      });
          
                    },
                    onChangeEnd: (value) {
                  setState(() {
                    _showTooltip = false; // Hide tooltip when interaction ends
                  });
                },
                    
                  ),
                ),
                if (_showTooltip)
                Positioned(
                  left: (_value*widget.width)-(_value<0.2?18:60), 
                  top: -40,
                  child: Container(
                    height: 45,
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                    
                    image:  DecorationImage(image:_value<0.2? const AssetImage('assets/tooltip_flip.png'):const AssetImage('assets/tooltip.png'),fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\$${(_value * 300).round()}/mo',
                      style: const TextStyle(color: Colors.white,fontSize: 10),
                    ),
                  ),
                ),
          
               
              ],
            ),
          ),
        ),
      
    );
  }
}