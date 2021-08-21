// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'detail_question_event.dart';
part 'detail_question_state.dart';
class DetailQuestionsBloc extends Bloc<DetailQuestionsEvent, DetailQuestionsState>{
  UserRepository _userRepository;
  DetailQuestionsBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(InitDetailQuestionsState());
  @override
  Stream<DetailQuestionsState> mapEventToState(DetailQuestionsEvent event) async* {
    if(event is InitDetailQuestionsEvent){
      yield* _mapDetailQuestionsEventToState(event.id);
    }
  }
  Stream<DetailQuestionsState> _mapDetailQuestionsEventToState(int id) async* {
    try{
      final response = await _userRepository.getDetailQuestion(id: id);
      // ignore: unrelated_type_equality_checks
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateDetailQuestionsState(List<Questions>.from(response.data.question));
      }
    }catch(e){
      throw e;
    }
  }
  static DetailQuestionsBloc of(BuildContext context) => BlocProvider.of<DetailQuestionsBloc>(context);
}