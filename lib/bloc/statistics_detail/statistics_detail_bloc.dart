// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'statistics_detail_event.dart';
part 'statistics_detail_state.dart';
class StatisticsDetailBloc extends Bloc<StatisticsDetailEvent, StatisticsDetailState>{
  UserRepository _userRepository;
  StatisticsDetailBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(InitStatisticsDetailState());
  @override
  Stream<StatisticsDetailState> mapEventToState(StatisticsDetailEvent event) async* {
    if(event is InitStatisticsDetailEvent){
      yield* _mapStatisticsDetailEventToState(event.id);
    }
  }
  Stream<StatisticsDetailState> _mapStatisticsDetailEventToState(int id) async* {
    try{
      final response = await _userRepository.getDetailStatistics(id: id);
      // ignore: unrelated_type_equality_checks
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateStatisticsDetailState((response.data!));
      }
    }catch(e){
      throw e;
    }
  }
  static StatisticsDetailBloc of(BuildContext context) => BlocProvider.of<StatisticsDetailBloc>(context);
}