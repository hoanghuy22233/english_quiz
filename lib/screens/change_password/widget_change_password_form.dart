// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:formz/formz.dart';

class WidgetChangePasswordForm extends StatefulWidget {
  @override
  _WidgetChangePasswordFormState createState() => _WidgetChangePasswordFormState();
}

class _WidgetChangePasswordFormState extends State<WidgetChangePasswordForm> {
  final _oldPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmNewPasswordFocusNode = FocusNode();

  bool obscureNewPassword = true;
  bool obscureConfirmNewPassword = true;

  @override
  void initState() {
    super.initState();
    _oldPasswordFocusNode.addListener(() {
      if (!_oldPasswordFocusNode.hasFocus) {
        context.read<ChangePasswordBloc>().add(OldPasswordUnfocused());
      }
    });
    _newPasswordFocusNode.addListener(() {
      if (!_newPasswordFocusNode.hasFocus) {
        context.read<ChangePasswordBloc>().add(NewPasswordUnfocused());
      }
    });
    _confirmNewPasswordFocusNode.addListener(() {
      if (!_confirmNewPasswordFocusNode.hasFocus) {
        context.read<ChangePasswordBloc>().add(RepeatPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ChangePasswordBloc.of(context);
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          GetSnackBarUtils.createSuccess(message: state.message);
          Future.delayed(Duration(seconds: 2), () {
            AuthenticationBloc.of(context).add(AuthenticationLogoutRequested());
            AppNavigator.navigateLogout();
          });
        }
        if (state.status.isSubmissionInProgress) {
          GetSnackBarUtils.createProgress();
        }
        if (state.status.isSubmissionFailure) {
          GetSnackBarUtils.createFailure(message: state.message);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: COLORS.WHITE,
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          child: Column(
            children: [
              Text(MESSAGES.CHANGE_PASSWORD, style: AppStyle.DEFAULT_MEDIUM_BOLD,),
              AppValue.vSpaceSmall,
              _buildTextFieldOldPassword(bloc),
              AppValue.vSpaceSmall,
              _buildTextFieldNewPassword(bloc),
              AppValue.vSpaceSmall,
              _buildTextFieldConfirmNewPassword(bloc),
              AppValue.vSpaceSmall,
              _buildButtonChangePassword(bloc),
            ],
          ),
        ),
      ),
    );
  }

  _buildButtonChangePassword(ChangePasswordBloc bloc) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return WidgetButton(
            onTap: () => state.status.isValidated ? bloc.add(FormChangePasswordSubmitted()) : null,
            enable: state.status.isValidated,
            backgroundColor: COLORS.BLUE,
            text: MESSAGES.SAVE,
          );
        }
    );
  }

  _buildTextFieldOldPassword(ChangePasswordBloc bloc) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state){
        return WidgetInput(
          onChanged: (value) => bloc.add(OldPasswordChanged(oldPassword: value)),
          labelText: MESSAGES.PASSWORD_OLD,
          focusNode: _oldPasswordFocusNode,
          isBorder: false,
          leadIcon: Icon(Icons.lock, color: COLORS.PRIMARY_COLOR,),
          errorText: state.oldPassword.invalid ? MESSAGES.PASSWORD_ERROR : null,
        );
      }
    );
  }

  _buildTextFieldNewPassword(ChangePasswordBloc bloc) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state){
          return WidgetInput(
            onChanged: (value) => bloc.add(NewPasswordChanged(newPassword: value)),
            labelText: MESSAGES.PASSWORD_NEW,
            obscureText: obscureNewPassword,
            focusNode: _newPasswordFocusNode,
            isBorder: false,
            errorText: state.newPassword.invalid ? MESSAGES.PASSWORD_ERROR : null,
            leadIcon: Icon(Icons.lock, color: COLORS.PRIMARY_COLOR,),
            endIcon: InkWell(
              onTap: () => setState(() => obscureNewPassword = !obscureNewPassword),
              child: Icon(
                obscureNewPassword
                    ? CommunityMaterialIcons.eye_outline
                    : CommunityMaterialIcons.eye_off_outline,
                color: COLORS.GREY,
                size: 20,
              ),
            ),
          );
        }
    );
  }

  _buildTextFieldConfirmNewPassword(ChangePasswordBloc bloc) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state){
        return WidgetInput(
          onChanged: (value) => bloc.add(RepeatPasswordChanged(repeatPassword: value)),
          labelText: MESSAGES.PASSWORD_NEW_AGAIN,
          obscureText: obscureConfirmNewPassword,
          focusNode: _confirmNewPasswordFocusNode,
          errorText: state.repeatPassword.invalid ? MESSAGES.PASSWORD_ERROR : null,
          isBorder: false,
          leadIcon: Icon(Icons.lock, color: COLORS.PRIMARY_COLOR,),
          endIcon: InkWell(
            onTap: () => setState(() => obscureConfirmNewPassword = !obscureConfirmNewPassword),
            child: Icon(
              obscureConfirmNewPassword
                  ? CommunityMaterialIcons.eye_outline
                  : CommunityMaterialIcons.eye_off_outline,
              color: COLORS.GREY,
              size: 20,
            ),
          ),
        );
      }
    );
  }
}
