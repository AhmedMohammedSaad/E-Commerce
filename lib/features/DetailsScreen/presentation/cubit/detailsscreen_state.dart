part of 'detailsscreen_cubit.dart';

abstract class DetailsscreenState extends Equatable {
  const DetailsscreenState();

  @override
  List<Object> get props => [];
}

class DetailsscreenInitial extends DetailsscreenState {}

//! the stats for handel the get comments
class CommentLoading extends DetailsscreenState {}

class CommentSuccses extends DetailsscreenState {}

class CommentError extends DetailsscreenState {
  final String message;

  const CommentError(this.message);
}

//! the stats for handel the post comments and rating
class AddCommentesAndRatLoading extends DetailsscreenState {}

class AddCommentesAndRatSuccses extends DetailsscreenState {}

class AddCommentesAndRatError extends DetailsscreenState {
  final String message;

  const AddCommentesAndRatError(this.message);
}
