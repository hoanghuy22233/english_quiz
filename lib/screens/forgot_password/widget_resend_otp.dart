import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils_libs/utils_libs.dart';

class WidgetResendOTP extends StatefulWidget {
  final String email;

  const WidgetResendOTP({Key? key, required this.email}) : super(key: key);


  @override
  _WidgetResendOTPState createState() =>
      _WidgetResendOTPState();
}

class _WidgetResendOTPState extends State<WidgetResendOTP> {
  late ResendOTPBloc resendOTPBloc;

  @override
  void initState() {
    super.initState();
    resendOTPBloc = BlocProvider.of<ResendOTPBloc>(context)..add(TimeInit(time: AppValue.VERIFY_RESEND_TIME));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResendOTPBloc, ResendOTPState>(
      listener: (context, state) async {
        if (state.isSubmitting) {
          GetSnackBarUtils.createProgress();
        }
        if (state.isSuccess) {
          await GetSnackBarUtils.createSuccess(message: state.message);
          BlocProvider.of<ResendOTPBloc>(context).add(TimeInit(time: AppValue.VERIFY_RESEND_TIME));
        }
        if (state.isFailure) {
          GetSnackBarUtils.createError(message: state.message);
        }
      },
      child: BlocBuilder<ResendOTPBloc, ResendOTPState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: WidgetResend(
                onTap: () => BlocProvider.of<ResendOTPBloc>(context).add(ResendOTPSubmit(email: widget.email)),
                time: state.time,
                isValid: isResendEnabled(),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isResendEnabled() {
    return resendOTPBloc.state.isFormValid &&
        !resendOTPBloc.state.isSubmitting;
  }
}
