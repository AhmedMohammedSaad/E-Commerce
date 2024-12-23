import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'navebarsd_state.dart';

class NavebarsdCubit extends Cubit<NavebarsdState> {
  NavebarsdCubit() : super(NavebarsdInitial());
  int courntIndex = 0;
  void changeCourntIndex(int index) {
    courntIndex = index;
    emit(CorontIndex());
  }
}
