import 'dart:io'; // ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/screens/screens.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv; // ignore: import_of_legacy_library_into_null_safe

class AccountInformation extends StatefulWidget {
  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> with SingleTickerProviderStateMixin {

  Future getImage() async {
    // showCupertinoModalPopup(
    //     context: context,
    //     builder: (context) {
    //       return CupertinoActionSheet(
    //         title: Text('Ảnh đại diện'),
    //         cancelButton: CupertinoActionSheetAction(
    //           child: Text('Huỷ'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //         actions: [
    //           CupertinoActionSheetAction(
    //             onPressed: () async {
    //               var images = await ImagePicker.pickImage(source: ImageSource.gallery);
    //               InfoUserBloc.of(context).add(UploadImagesEvent(file: File(images.path), bloc: ProfileBloc.of(context)));
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('Chọn ảnh có sẵn'),
    //           ),
    //           CupertinoActionSheetAction(
    //             onPressed: () async {
    //               var images = await ImagePicker.pickImage(source: ImageSource.camera);
    //               InfoUserBloc.of(context).add(UploadImagesEvent(file: File(images.path), bloc: ProfileBloc.of(context)));
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('Chụp ảnh mới'),
    //           )
    //         ],
    //       );
    //     });
    final blocProfile = ProfileBloc.of(context);
    var images = await ImagePicker.pickImage(source: ImageSource.gallery);
    blocProfile.add(ProfileUploadAvatar(avatar: File(images.path)));
    //InfoUserBloc.of(context).add(UploadImagesEvent(file: File(images.path), bloc: ProfileBloc.of(context)));
  }

  @override
  Widget build(BuildContext context) {
    return WidgetTouchHideKeyBoard(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: WidgetBackButton(),
          ),
          title: Text(MESSAGES.INFORMATION_ACCOUNT, style: AppStyle.DEFAULT_MEDIUM.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Container(
            color: COLORS.WHITE,
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      InfoUserBloc.of(context)..add(InitDataEvent());
                      await Future.delayed(Duration(seconds: 2));
                    },
                    color: COLORS.WHITE,
                    backgroundColor: COLORS.PRIMARY_COLOR,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: BlocBuilder<InfoUserBloc, InfoUserState>(
                        bloc: InfoUserBloc.of(context)..add(InitDataEvent()),
                        builder: (context, state) {
                          if (state is UpdateInfoUserState) {
                            final user = state.infoUser;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Form(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: getImage,
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 15),
                                                    child: WidgetAvatar(url: user.image ?? ''),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: WidgetContainerImage(
                                                        image: ICONS.CAMERA_ICON,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            AppValue.hSpaceTiny,
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(user.name!= null ?
                                                  user.name!.length > 25 ? '${user.name!.substring(0, 25)} ...' :  user.name! :
                                                  MESSAGES.NOT_SETUP, style: AppStyle.DEFAULT_MEDIUM_BOLD,
                                                ),
                                                Text(
                                                  user.email ?? MESSAGES.NOT_SETUP,
                                                  style: AppStyle.DEFAULT_MEDIUM
                                                      .copyWith(
                                                    color: COLORS.PRIMARY_COLOR,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        AppValue.vSpace(20),
                                        // _titleText(MESSAGES.EMAIL),
                                        // AppValue.vSpaceTiny,
                                        // _titleText(
                                        //   accountController.notSetup.text,
                                        //   box: true,
                                        // ),
                                        AppValue.vSpaceSmall,
                                        _titleText(MESSAGES.CODE_LOGIN),
                                        AppValue.vSpaceTiny,
                                        _titleText(
                                          user.code ?? MESSAGES.NOT_SETUP,
                                          box: true,
                                        ),
                                        AppValue.vSpaceSmall,

                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            _titleText(MESSAGES.GENDER),
                                            ToggleSwitch(
                                              minWidth: 75.0,
                                              minHeight: 30,
                                              initialLabelIndex: user.gender!,
                                              cornerRadius: 20.0,
                                              changeOnTap: false,
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
                                              onToggle: (index) {},
                                            ),
                                          ],
                                        ),

                                        AppValue.vSpaceSmall,
                                        _titleText(MESSAGES.PHONE),
                                        AppValue.vSpaceTiny,
                                        _titleText(
                                          user.phone ?? MESSAGES.NOT_SETUP,
                                          box: true,
                                        ),
                                        // AppValue.vSpaceSmall,
                                        // _titleText(MESSAGES.BIRTHDAY),
                                        // AppValue.vSpaceTiny,
                                        // _titleText(
                                        //   accountController.notSetup.text,
                                        //   box: true,
                                        // ),
                                        AppValue.vSpaceSmall,
                                        _titleText(MESSAGES.ADDRESS),
                                        AppValue.vSpaceTiny,
                                        _titleText(
                                            user.address ?? MESSAGES.NOT_SETUP,
                                            box: true,
                                            height: 90,
                                            maxLine: 2
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          else {
                            return Center(
                              child: TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<InfoUserBloc, InfoUserState>(
                          bloc: InfoUserBloc.of(context)..add(InitDataEvent()),
                          builder: (context, state) {
                            if (state is UpdateInfoUserState) {
                              return WidgetButton(
                                onTap: () => AppNavigator.navigateChangeInformationAccount(state.infoUser),
                                text: MESSAGES.CHANGE_INFORMATION,
                                backgroundColor: COLORS.BLUE,
                              );
                            }
                            else {
                              return Center(
                                child: TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2),
                              );
                            }
                          },
                        ),
                      ),
                      AppValue.hSpaceTiny,
                      Expanded(
                        child: WidgetButton(
                          onTap: ()=> AppNavigator.navigateChangePassword(),
                          text: MESSAGES.CHANGE_PASSWORD,
                          backgroundColor: COLORS.BLUE,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _titleText(String title, {bool box = false, double? height, int? maxLine}) {
    return box
    ? Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: height ?? AppValue.ACTION_BAR_HEIGHT,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: COLORS.BLACK),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: WidgetText(
                      title: title,
                      textAlign: TextAlign.left,
                      style: AppStyle.DEFAULT_MEDIUM,
                      maxLine: maxLine,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    : Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: WidgetText(
          title: title,
          textAlign: TextAlign.left,
          style: AppStyle.DEFAULT_MEDIUM_BOLD,
        ),
      );
  }
}
