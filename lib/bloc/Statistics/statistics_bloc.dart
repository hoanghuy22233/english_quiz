// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'statistics_event.dart';
part 'statistics_state.dart';
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState>{
  UserRepository _userRepository;
  StatisticsBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(InitStatisticsState());
  @override
  Stream<StatisticsState> mapEventToState(StatisticsEvent event) async* {
    if(event is InitStatisticsEvent){
      yield* _mapStatisticsEventToState();
    }
  }
  Stream<StatisticsState> _mapStatisticsEventToState() async* {
    try{
      final response = await _userRepository.getStatistics();
      // ignore: unrelated_type_equality_checks
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateStatisticsState(List<StatisticsData>.from(response.data));
      }
    }catch(e){
      throw e;
    }
  }
  static StatisticsBloc of(BuildContext context) => BlocProvider.of<StatisticsBloc>(context);
}