part of 'photo_bloc.dart';

@immutable
abstract class PhotoState extends Equatable {
  const PhotoState([List props = const []]) : super();
}

class PhotoInitial extends PhotoState {
  @override
  List<Object> get props => this.props;
}

class GetPhotoState extends PhotoState {
  final File photo;

  GetPhotoState(this.photo) : super([photo]);

  @override
  List<Object> get props => [photo];
}
