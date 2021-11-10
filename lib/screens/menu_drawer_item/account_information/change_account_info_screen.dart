// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ChangeAccountInformation extends StatefulWidget {
  @override
  _ChangeAccountInformationState createState() =>
      _ChangeAccountInformationState();
}

class _ChangeAccountInformationState extends State<ChangeAccountInformation> {

  late bool gender, birthday = true, phone = true, username = true, fullname = true, address = true, email = true;

  bool get isPopulated => birthday && phone && username && fullname && address && email;

  @override
  Widget build(BuildContext context) {
    final blocProfile = ProfileBloc.of(context);
    InfoUser info = Get.arguments;
    return WidgetTouchHideKeyBoard(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: WidgetBackButton(),
          ),
          title: Text(MESSAGES.CHANGE_INFORMATION, style: AppStyle.DEFAULT_MEDIUM.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Container(
            color: COLORS.WHITE,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppValue.vSpaceSmall,
                                  _titleText(MESSAGES.FULLNAME),
                                  AppValue.vSpaceTiny,
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: WidgetInput(
                                      initialValue: info.name ?? '',
                                      hint: MESSAGES.FULLNAME,
                                      errorText: username ? null : MESSAGES.NOT_EMPTY,
                                      onChanged: (value){
                                        blocProfile.add(ProfileChangedFullName(value));
                                        setState(() {
                                          username = Validator.isValidNotEmpty(value);
                                        });
                                      },
                                    ),
                                  ),

                                  AppValue.vSpaceSmall,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      _titleText(MESSAGES.GENDER),
                                      ToggleSwitch(
                                        minWidth: 75.0,
                                        minHeight: 30,
                                        initialLabelIndex: info.gender!,
                                        cornerRadius: 20.0,
                                        activeFgColor: Colors.white,
                                        inactiveBgColor: Colors.grey,
                                        inactiveFgColor: Colors.white,
                                        labels: [
                                          MESSAGES.FEMALE,
                                          MESSAGES.MALE
                                        ],
                                        icons: [
                                          FontAwesomeIcons.venus,
                                          FontAwesomeIcons.mars
                                        ],
                                        activeBgColors: [
                                          Colors.pink,
                                          Colors.blue
                                        ],
                                        onToggle: (index) {
                                          blocProfile.add(ProfileChangedGender(index));
                                        },
                                      ),
                                    ],
                                  ),

                                  AppValue.vSpaceSmall,
                                  _titleText(MESSAGES.PHONE),
                                  AppValue.vSpaceTiny,
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: WidgetInput(
                                      initialValue: info.phone ?? '',
                                      hint: MESSAGES.PHONE,
                                      onChanged: (value){
                                        blocProfile.add(ProfileChangedPhone(value));
                                        setState(() {
                                          phone = Validator.isValidTel(value);
                                        });
                                      },
                                      errorText: phone ? null : MESSAGES.INVALID_PHONE,
                                      inputType: TextInputType.phone,
                                    ),
                                  ),

                                  // AppValue.vSpaceSmall,
                                  // _titleText(MESSAGES.BIRTHDAY),
                                  // AppValue.vSpaceTiny,
                                  // Padding(
                                  //   padding:
                                  //       EdgeInsets.symmetric(horizontal: 15),
                                  //   child: WidgetInput(
                                  //     initialValue: '20/09/1997',
                                  //     hint: MESSAGES.BIRTHDAY,
                                  //     inputType: TextInputType.datetime,
                                  //     errorText: birthday ? null : MESSAGES.INVALID_DATE,
                                  //     onChanged: (value) {
                                  //       //blocProfile.add(ProfileChangedBirthday(value));
                                  //       setState(() {
                                  //         birthday = Validator.isValidDob(value);
                                  //       });
                                  //     },
                                  //   ),
                                  // ),

                                  AppValue.vSpaceSmall,
                                  _titleText(MESSAGES.ADDRESS),
                                  AppValue.vSpaceTiny,
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: WidgetInput(
                                      height: 90,
                                      maxLine: 3,
                                      inputType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      initialValue: info.address ?? '',
                                      hint: MESSAGES.ADDRESS,
                                      errorText: address ? null : MESSAGES.NOT_EMPTY,
                                      onChanged: (value) {
                                        blocProfile.add(ProfileChangedAddress(value));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: WidgetButton(
                    //onTap: () => isPopulated ? blocProfile.add(FormSubmitProfileEvent()) : GetSnackBarUtils.createWarning(message: MESSAGES.INFORMATION_ERROR),
                    onTap: () => blocProfile.add(FormSubmitProfileEvent()),
                    enable: isPopulated,
                    text: MESSAGES.SAVE,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _titleText(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: WidgetText(
        title: title,
        textAlign: TextAlign.left,
        style: AppStyle.DEFAULT_MEDIUM_BOLD,
      ),
    );
  }
}
