// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'theory_container_event.dart';
part 'theory_container_state.dart';
class TheoryContainerBloc extends Bloc<TheoryContainerEvent, TheoryContainerState>{
  UserRepository _userRepository;

  TheoryContainerBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(UpdateContainerTheory.initial());

  @override
  Stream<TheoryContainerState> mapEventToState(TheoryContainerEvent event) async* {
    if (event is InitTheoryContainerEvent) {
      yield* _mapTheoryContainerEventToState(state as UpdateContainerTheory);
    }
  }

  Stream<TheoryContainerState> _mapTheoryContainerEventToState(UpdateContainerTheory state) async* {
    try{
      final response = await _userRepository.getTheory(type: 3);
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateContainerTheory(theorys: state.theorys.copyWith(data: response.data));
      }
    }catch(e){
      throw e;
    }
  }


  static TheoryContainerBloc of(BuildContext context) => BlocProvider.of<TheoryContainerBloc>(context);
}