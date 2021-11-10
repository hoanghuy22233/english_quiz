import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'result_state.dart';
part 'result_event.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState>{
  UserRepository _userRepository;
  ResultBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(InitResultState());
  @override
  Stream<ResultState> mapEventToState(ResultEvent event) async* {
    if(event is InitResultEvent){
      yield* _mapResultEventToState(type: event.type,idQ: event.idQ);
    }
  }
  Stream<ResultState> _mapResultEventToState({required int type,required int idQ}) async* {
    try{
      final response = await _userRepository.postResult(id: type,idQ: idQ);
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateResultState(response.data!);
      }
    }catch(e){
      throw e;
    }
  }
  static ResultBloc of(BuildContext context) => BlocProvider.of<ResultBloc>(context);
}