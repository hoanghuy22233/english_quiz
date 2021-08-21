import 'package:community_material_icon/community_material_icon.dart';
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:english_quiz/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'package:formz/formz.dart';

class WidgetResetPasswordResetForm extends StatefulWidget {
  final String email;

  const WidgetResetPasswordResetForm({Key? key, required this.email}) : super(key: key);

  @override
  _WidgetResetPasswordResetFormState createState() =>
      _WidgetResetPasswordResetFormState();
}

class _WidgetResetPasswordResetFormState extends State<WidgetResetPasswordResetForm> {

  final _otpFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmNewPasswordFocusNode = FocusNode();

  bool obscurePassword = true;
  bool obscureRePassword = true;

  @override
  void initState() {
    _otpFocusNode.addListener(() {
      if (!_otpFocusNode.hasFocus) {
        context.read<ResetPasswordBloc>().add(OTPResetUnfocused());
      }
    });
    _newPasswordFocusNode.addListener(() {
      if (!_newPasswordFocusNode.hasFocus) {
        context.read<ResetPasswordBloc>().add(NewPasswordResetUnfocused());
      }
    });
    _confirmNewPasswordFocusNode.addListener(() {
      if (!_confirmNewPasswordFocusNode.hasFocus) {
        context.read<ResetPasswordBloc>().add(RepeatPasswordResetUnfocused());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordFocusNode.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ResetPasswordBloc.of(context);
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          GetSnackBarUtils.createSuccess(message: MESSAGES.SUCCESS);
          Future.delayed(Duration(seconds: 2), () {
            AppNavigator.navigateLogout();
          });
        }
        if (state.status.isSubmissionInProgress) {
          GetSnackBarUtils.createProgress();
        }
        if (state.status.isSubmissionFailure) {
          GetSnackBarUtils.createFailure();
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
              Text(MESSAGES.NEW_PASSWORD, style: AppStyle.DEFAULT_MEDIUM_BOLD,),
              AppValue.vSpaceSmall,
              Text(MESSAGES.CONFIRMATION_CODE_MESSAGE, style: AppStyle.DEFAULT_SMALLs, textAlign: TextAlign.center,),
              AppValue.vSpaceTiny,
              Text(widget.email, style: AppStyle.DEFAULT_SMALLs_BOLD, textAlign: TextAlign.center,),
              AppValue.vSpaceTiny,
              Text(MESSAGES.CONFIRMATION_SUB_MESSAGE, style: AppStyle.DEFAULT_SMALLs, textAlign: TextAlign.center,),
              AppValue.vSpaceTiny,
              _buildTextFieldOTP(bloc),
              AppValue.vSpaceTiny,
              _buildTextFieldNewPassword(bloc),
              AppValue.vSpaceTiny,
              _buildTextFieldConfirmNewPassword(bloc),
              AppValue.vSpaceTiny,
              _buildResend(),
              AppValue.vSpaceTiny,
              _buildButtonResetPassword(bloc),

            ],
          ),
        ),
      ),
    );
  }

  _buildResend() => WidgetResendOTP(email: widget.email);

  _buildButtonResetPassword(ResetPasswordBloc bloc) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return WidgetButton(
          onTap: () => state.status.isValidated ? bloc.add(FormResetPasswordSubmitted()) : null,
          enable: state.status.isValidated,
          backgroundColor: COLORS.PRIMARY_COLOR,
          text: MESSAGES.OK,
        );
      },
    );
  }

  _buildTextFieldOTP(ResetPasswordBloc bloc) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return WidgetInput(
          onChanged: (value) => bloc.add(OTPResetChanged(otp: value)),
          inputType: TextInputType.number,
          focusNode: _otpFocusNode,
          isBorder: false,
          maxLength: 6,
          labelText: MESSAGES.OTP,
          errorText: state.otp.invalid
              ? MESSAGES.OTP_ERROR
              : null,
          leadIcon: WidgetContainerImage(
            height: 20,
            width: 20,
            image: ICONS.ICON_OTP,
            colorImage: COLORS.PRIMARY_COLOR,
          ),
        );
      },
    );

  }

  _buildTextFieldNewPassword(ResetPasswordBloc bloc) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return WidgetInput(
          onChanged: (value) => bloc.add(NewPasswordResetChanged(newPassword: value)),
          labelText: MESSAGES.PASSWORD_NEW,
          errorText: state.newPassword.invalid
              ? MESSAGES.PASSWORD_ERROR
              : null,
          obscureText: obscurePassword,
          focusNode: _newPasswordFocusNode,
          isBorder: false,
          leadIcon: Icon(Icons.lock, color: COLORS.PRIMARY_COLOR,),
          endIcon: InkWell(
            onTap: () => setState(() => obscurePassword = !obscurePassword),
            child: Icon(
              obscurePassword
                  ? CommunityMaterialIcons.eye_outline
                  : CommunityMaterialIcons.eye_off_outline,
              color: COLORS.GREY,
              size: 20,
            ),
          ),
        );
      },
    );
  }

  _buildTextFieldConfirmNewPassword(ResetPasswordBloc bloc) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return WidgetInput(
          onChanged: (value) => bloc.add(RepeatPasswordResetChanged(repeatPassword: value)),
          labelText: MESSAGES.PASSWORD_NEW_AGAIN,
          errorText: state.repeatPassword.invalid
              ? MESSAGES.PASSWORD_ERROR
              : null,
          obscureText: obscureRePassword,
          focusNode: _confirmNewPasswordFocusNode,
          isBorder: false,
          leadIcon: Icon(Icons.lock, color: COLORS.PRIMARY_COLOR,),
          endIcon: InkWell(
            onTap: () => setState(() => obscureRePassword = !obscureRePassword),
            child: Icon(
              obscureRePassword
                  ? CommunityMaterialIcons.eye_outline
                  : CommunityMaterialIcons.eye_off_outline,
              color: COLORS.GREY,
              size: 20,
            ),
          ),
        );
      },
    );
  }

}
