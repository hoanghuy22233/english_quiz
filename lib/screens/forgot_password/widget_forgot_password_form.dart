// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class WidgetForgotPasswordForm extends StatefulWidget {
  @override
  _WidgetForgotPasswordFormState createState() => _WidgetForgotPasswordFormState();
}

class _WidgetForgotPasswordFormState extends State<WidgetForgotPasswordForm> {
  final _emailFocusNode = FocusNode();

  bool obscurePassword = true;
  String email = '';

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<ForgotPasswordBloc>().add(EmailForgotPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ForgotPasswordBloc.of(context);
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          GetSnackBarUtils.createSuccess(message: state.message);
          Future.delayed(Duration(seconds: 2), () {
            AppNavigator.navigateForgotPasswordReset(state.email.value);
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
              Text(MESSAGES.FORGOT_PASSWORD, style: AppStyle.DEFAULT_MEDIUM_BOLD,),
              AppValue.vSpaceSmall,
              Text(MESSAGES.TITLE_FORGOT_PASSWORD, style: AppStyle.DEFAULT_SMALLs, textAlign: TextAlign.center,),
              AppValue.vSpaceSmall,
              _buildTextFieldUsername(bloc),
              AppValue.vSpaceSmall,
              _buildButtonForgotPassword(bloc),
            ],
          ),
        ),
      ),
    );
  }

  _buildButtonForgotPassword(ForgotPasswordBloc bloc) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return WidgetButton(
            onTap: () => state.status.isValidated ? bloc.add(FormForgotPasswordSubmitted()) : null,
            enable: state.status.isValidated,
            backgroundColor: COLORS.PRIMARY_COLOR,
            text: MESSAGES.FORGOT_PASSWORD,
          );
        }
    );
  }

  _buildTextFieldUsername(ForgotPasswordBloc bloc) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return WidgetInput(
          onChanged: (value) => bloc.add(EmailForgotPasswordChanged(email: value)),
          inputType: TextInputType.emailAddress,
          focusNode: _emailFocusNode,
          isBorder: false,
          errorText: state.email.invalid
              ? MESSAGES.EMAIL_ERROR
              : null,
          labelText: MESSAGES.EMAIL,
          leadIcon: Icon(Icons.email, color: COLORS.PRIMARY_COLOR,),
        );
      }
    );
  }
}
