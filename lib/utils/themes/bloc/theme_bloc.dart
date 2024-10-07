import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domi_labs/utils/themes/dark_theme.dart';
import 'package:domi_labs/utils/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {


  ThemeData _themeData=light_theme;

  ThemeData get themeData=>_themeData;
  ThemeBloc() : super(ThemeInitial()) {
    on<ToggleTheme>(toggleTheme);
  }

  FutureOr<void> toggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {


    if(_themeData==light_theme){

      _themeData=darkTheme;
    }
    else{

      _themeData=light_theme;
    }


    emit(UpdatedThemeState());
  }
}
