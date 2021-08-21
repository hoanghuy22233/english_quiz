part of 'post_bloc.dart';
abstract class PostState extends Equatable{
  const PostState();
  @override
  List<Object?> get props => [];
}

class InitPostState extends PostState{}

class UpdatePostState extends PostState{
  final List<PostData> dataPost;
  UpdatePostState(this.dataPost);
  @override
  List<Object?> get props => [dataPost];
}