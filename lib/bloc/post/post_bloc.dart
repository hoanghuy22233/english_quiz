import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'post_state.dart';
part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState>{
  UserRepository _userRepository;
  PostBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(InitPostState());
  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if(event is InitPostEvent){
      yield* _mapPostEventToState(type: event.type);
    }
  }
  Stream<PostState> _mapPostEventToState({required int type}) async* {
    try{
      final response = await _userRepository.getPost(type: type);
      if(response.status == BASE_URL.SUCCESS){
        yield UpdatePostState(response.data);
      }
    }catch(e){
      throw e;
    }
  }
  static PostBloc of(BuildContext context) => BlocProvider.of<PostBloc>(context);
}