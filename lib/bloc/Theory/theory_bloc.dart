// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'theory_event.dart';
part 'theory_state.dart';
class TheoryBloc extends Bloc<TheoryEvent, TheoryState>{
  UserRepository _userRepository;

  TheoryBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(UpdateTheory.initial());

  @override
  Stream<TheoryState> mapEventToState(TheoryEvent event) async* {
    if (event is InitTheoryEvent) {
      yield* _mapTheoryEventToState(state as UpdateTheory);
    }
    else if(event is InitDetailTheoryEvent){
      yield* _mapDetailTheoryEventToState(state as UpdateTheory, event.theoryId);
    }
  }

  Stream<TheoryState> _mapTheoryEventToState(UpdateTheory state) async* {
    try{
      final response = await _userRepository.getTheory(type: 1);
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateTheory(theory: state.theory.copyWith(data: response.data));
      }
    }catch(e){
      throw e;
    }
  }

  Stream<TheoryState> _mapDetailTheoryEventToState(UpdateTheory state, int id) async* {
    try{
      final response = await _userRepository.getDetailTheory(id: id);
      if(response.status == BASE_URL.SUCCESS){
     //   AppNavigator.navigateDetailTheory(response.data);
      }
    }catch(e){
      await GetSnackBarUtils.createFailure(message: MESSAGES.CONNECT_ERROR);
      throw e;
    }
  }

  static TheoryBloc of(BuildContext context) => BlocProvider.of<TheoryBloc>(context);
}