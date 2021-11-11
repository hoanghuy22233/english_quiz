import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'notification_state.dart';
part 'notification_event.dart';

class UserNotificationBloc extends Bloc<UserNotificationEvent, UserNotificationState>{
  UserRepository _userRepository;
  UserNotificationBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(UpdateUserNotification.initial());
  @override
  Stream<UserNotificationState> mapEventToState(UserNotificationEvent event) async* {
    if(event is InitUserNotificationEvent){
      yield* _mapUserNotificationEventToState(state as UpdateUserNotification);
    } else if(event is InitDetailNotificationEvent){
      yield* _mapDetailNotificationEventToState(state as UpdateUserNotification, event.notiId);
    }
  }

  Stream<UserNotificationState> _mapUserNotificationEventToState(UpdateUserNotification state) async* {
    try{
      final response = await _userRepository.getNotification();
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateUserNotification(notification: state.notification.copyWith(userNotification: response.data));
      }
    }catch(e){
      throw e;
    }
  }

  Stream<UserNotificationState> _mapDetailNotificationEventToState(UpdateUserNotification state, int id) async* {
    try{
      final response = await _userRepository.getDetailNotification(id: id);
      if(response.status == BASE_URL.SUCCESS){
        AppNavigator.navigateDetailNotification(response.data);
        if(response.data.pivot.status == 0){
          try{
            final responseSeen = await _userRepository.seenNotification(id: id);
            if(responseSeen.status == BASE_URL.SUCCESS){
              print('Thay đổi thành công');
            }
          }
          catch(e){
            throw e;
          }
        }
      }
    }catch(e){
      await GetSnackBarUtils.createFailure(message: MESSAGES.CONNECT_ERROR);
      throw e;
    }
  }

  static UserNotificationBloc of(BuildContext context) => BlocProvider.of<UserNotificationBloc>(context);
}