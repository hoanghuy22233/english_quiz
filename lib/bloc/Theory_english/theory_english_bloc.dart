// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'theory_english_event.dart';
part 'theory_english_state.dart';
class TheoryEnglishBloc extends Bloc<TheoryEnglishEvent, TheoryEnglishState>{
  UserRepository _userRepository;

  TheoryEnglishBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(UpdateTheoryEnglish.initial());

  @override
  Stream<TheoryEnglishState> mapEventToState(TheoryEnglishEvent event) async* {
    if (event is InitTheoryEnglishEvent) {
      yield* _mapTheoryEnglishEventToState(state as UpdateTheoryEnglish);
    }
    else if(event is InitDetailTheoryEnglishEvent){
      yield* _mapDetailTheoryEnglishEventToState(state as UpdateTheoryEnglish, event.theoryId);
    }
  }

  Stream<TheoryEnglishState> _mapTheoryEnglishEventToState(UpdateTheoryEnglish state) async* {
    try{
      final response = await _userRepository.getTheory(type: 2);
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateTheoryEnglish(theory: state.theory.copyWith(data: response.data));
      }
    }catch(e){
      throw e;
    }
  }

  Stream<TheoryEnglishState> _mapDetailTheoryEnglishEventToState(UpdateTheoryEnglish state, int id) async* {
    try{
      final response = await _userRepository.getDetailTheory(id: id);
      if(response.status == BASE_URL.SUCCESS){
       // AppNavigator.navigateDetailTheory(response.data);
      }
    }catch(e){
      await GetSnackBarUtils.createFailure(message: MESSAGES.CONNECT_ERROR);
      throw e;
    }
  }

  static TheoryEnglishBloc of(BuildContext context) => BlocProvider.of<TheoryEnglishBloc>(context);
}