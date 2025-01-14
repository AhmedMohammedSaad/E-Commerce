import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log("$change change ");
  }

  @override
  void onClose(BlocBase bloc) {
    log("$onClose onClose ");
  }

  @override
  void onCreate(BlocBase bloc) {
    log("$onCreate onCreate ");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log("$onError onError ");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log("$onEvent onEvent ");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("$onTransition onTransition ");
  }
}
