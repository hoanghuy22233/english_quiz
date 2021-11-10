// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'test_event.dart';
part 'test_state.dart';
class TestsBloc extends Bloc<TestsEvent, TestsState>{
  UserRepository _userRepository;
  TestsBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(InitTestState());
  @override
  Stream<TestsState> mapEventToState(TestsEvent event) async* {
    if(event is InitTestEvent){
      yield* _mapTestEventToState(event.testId);
    }
  }
  Stream<TestsState> _mapTestEventToState(int testId) async* {
    yield TestLoadingState();
    try{
      final response = await _userRepository.getTest(type: testId);
      // ignore: unrelated_type_equality_checks
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateTestState(List<Tests>.from(response.data!));
      }
    }catch(e){
      throw e;
    }
  }
  static TestsBloc of(BuildContext context) => BlocProvider.of<TestsBloc>(context);
}