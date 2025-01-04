import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detailsscreen_state.dart';

class DetailsscreenCubit extends Cubit<DetailsscreenState> {
  DetailsscreenCubit() : super(DetailsscreenInitial());
}
