// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widget_dialog_register.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:formz/formz.dart';

class WidgetLoginForm extends StatefulWidget {
  @override
  _WidgetLoginFormState createState() => _WidgetLoginFormState();
}

class _WidgetLoginFormState extends State<WidgetLoginForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LoginBloc>().add(CodeUnfocused());
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = LoginBloc.of(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          GetSnackBarUtils.createSuccess(message: state.message);
          Future.delayed(Duration(seconds: 2), () {
            AppNavigator.navigateMain();
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
              Text(MESSAGES.LOGIN, style: AppStyle.DEFAULT_MEDIUM_BOLD,),
              AppValue.vSpaceSmall,
              _buildTextFieldUsername(bloc),
              AppValue.vSpaceSmall,
              _buildTextFieldPassword(bloc),
              AppValue.vSpaceSmall,
              _buildForgotPassword(),
              AppValue.vSpaceSmall,
              _buildButtonLogin(bloc),
              AppValue.vSpaceSmall,
              _buildButtonRegister(),
            ],
          ),
        ),
      ),
    );
  }

  _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => AppNavigator.navigateForgotPassword(),
        child: Text(
          MESSAGES.FORGOT_PASSWORD + "?",
          style: AppStyle.DEFAULT_SMALL_BOLD.copyWith(color: COLORS.PRIMARY_COLOR),
        ),
      ),
    );
  }

  _buildButtonLogin(LoginBloc bloc) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return WidgetButton(
            onTap: () => state.status.isValidated ? bloc.add(FormSubmitted()) : null,
            enable: state.status.isValidated,
            backgroundColor: COLORS.PRIMARY_COLOR,
            text: MESSAGES.LOGIN,
          );
        }
    );
  }

  _buildButtonRegister() {
    return   InkWell(
      onTap: (){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WidgetDialogRegister();
          },
        );
      }
      ,
      child: WidgetContainerCenter(
          width:  AppValue.widths,
          height: 35,
          boxDecoration: BoxDecoration(
              color:  COLORS.BLUE,
              borderRadius: BorderRadius.circular(6)
          ),
          child: Text("Đăng ký", style: AppStyle.DEFAULT_MEDIUM.copyWith(color: Colors.white),
          )),
    );
  }




  _buildTextFieldPassword(LoginBloc bloc) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return WidgetInput(
            onChanged: (value) => bloc.add(PasswordChanged(password: value)),
            labelText: MESSAGES.PASSWORD,
            errorText: state.password.invalid ? MESSAGES.PASSWORD_ERROR : null,
            obscureText: obscurePassword,
            focusNode: _passwordFocusNode,
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
        }
    );
  }

  _buildTextFieldUsername(LoginBloc bloc) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return WidgetInput(
          onChanged: (value) => bloc.add(CodeChanged(code: value)),
          inputType: TextInputType.number,
          focusNode: _emailFocusNode,
          isBorder: false,
          maxLength: 6,
          labelText: MESSAGES.CODE_LOGIN,
          errorText: state.code.invalid ? MESSAGES.CODE_ERROR : null,
          leadIcon: Icon(Icons.person, color: COLORS.PRIMARY_COLOR,),
        );
      }
    );
  }
}
