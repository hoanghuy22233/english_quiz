import 'package:english_quiz/api_resfull/user_repository.dart';
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/storages/storages.dart';
import 'package:utils_libs/utils_libs.dart' show BASE_URL, DataUser, GetSnackBarUtils, InfoUser, MESSAGES, PreferencesKey, User; // ignore: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'info_user_event.dart';
part 'info_user_state.dart';

class InfoUserBloc extends Bloc<InfoUserEvent, InfoUserState>{
  final EventRepositoryStorage _localRepository;
  final UserRepository userRepository;
  final BuildContext? context;

  InfoUserBloc({required UserRepository userRepository, required EventRepositoryStorage localRepository, this.context})
      : userRepository = userRepository, _localRepository = localRepository, super(const InitUserState.unknown());

  @override
  Stream<InfoUserState> mapEventToState(InfoUserEvent event) async* {
    if(event is LoadResponseToken){
      yield* _mapResponseTokenToState();
    } else if (event is InitDataEvent) {
      yield* _mapInfoUserState();
    } else if (event is AddDataEvent) {
      yield* _mapAddDataInfoUserState();
    }
  }
  Stream<InfoUserState> _mapResponseTokenToState() async* {
    try{
      final loadUser  = await this._localRepository.loadUser();
      yield UploadUserState(user: InfoUser.fromJson(json.decode(loadUser)));
    }catch(e){
      throw e;
    }
  }
  Stream<InfoUserState> _mapInfoUserState() async* {
    try {
      final loadUser = await this._localRepository.loadUser();
      userRepository.addUser(DataUser.fromJson(json.decode(loadUser)["data"]));
    } catch (e) {
      throw e;
    }
  }
  Stream<InfoUserState> _mapAddDataInfoUserState() async* {
    try {
      final infoUser = await this.userRepository.getInfoUser();
      if(infoUser.data.user.statusUser != BASE_URL.LOCK){
        await _localRepository.saveUserID(infoUser.data.user.id.toString());
        yield UpdateInfoUserState(infoUser.data.user);
      }
    } catch (e) {
      yield ErrorState();
      throw e;
    }
  }
  static InfoUserBloc of(BuildContext context) => BlocProvider.of<InfoUserBloc>(context);
}