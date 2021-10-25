import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/screens/screens.dart';
import 'package:english_quiz/widgets/widget_button_home.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      body: AnimatedDrawer(
        homePageXValue: 300,
        homePageYValue: 80,
        homePageAngle: -0.2,
        homePageSpeed: 250,
        shadowXValue: 272,
        shadowYValue: 110,
        shadowAngle: -0.275,
        shadowSpeed: 550,
        openIcon: Icon(Icons.menu_open,size: 40, color: Color(0xFFFFFFFF)),
        closeIcon: Icon(Icons.arrow_back_ios,size: 25, color: Color(0xFFFFFFFF)),
        shadowColor: Colors.blue[200],
        backgroundGradient: LinearGradient(
          colors: [ const Color(0xFF0983CA),
            const Color(0xFF79D0FE)],
        ),
        menuPageContent: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 15),
          child: Container(
            child: MainDrawer(
              onPress: handleOnPressItemMenu,
            ),

            // BlocBuilder<InfoUserBloc, InfoUserState>(
            //   bloc: InfoUserBloc.of(context)..add(InitDataEvent())..add(AddDataEvent()),
            //   builder: (context, state) {
            //     if (state is UpdateInfoUserState) {
            //       return MainDrawer(
            //         onPress: handleOnPressItemMenu,
            //         infoUser: state.infoUser,
            //       );
            //     } else if (state is ErrorState) {
            //       return Container(
            //         child: SingleChildScrollView(
            //           child: Column(
            //             children: [
            //               TrailError(height: 250, width: 250),
            //               Text(MESSAGES.CONNECT_ERROR, style: AppStyle.DEFAULT_MEDIUM),
            //               AppValue.vSpaceSmall,
            //               WidgetButton(
            //                 onTap: () => AppNavigator.navigateLogout(),
            //                 enable: true,
            //                 backgroundColor: COLORS.PRIMARY_COLOR,
            //                 text: MESSAGES.TRY,
            //                 width: 120,
            //               )
            //             ],
            //           ),
            //         ),
            //       );
            //     } else {
            //       return Center(
            //         child: TrailLoading(height: 150, width: 150),
            //       );
            //     }
            //   }
            // ),
          ),
        ),
        homePageContent: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text(MESSAGES.BACK_TO_EXIT, style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.WHITE),),
          ),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      const Color(0xFF0983CA),
                      const Color(0xFF79D0FE),
                    ],
                    begin: const FractionalOffset(0.0, 1.0),
                    end: const FractionalOffset(0.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
              child: BlocBuilder<InfoUserBloc, InfoUserState>(
                  bloc: InfoUserBloc.of(context)..add(InitDataEvent())..add(AddDataEvent()),
                  builder: (context, state) {
                    if (state is UpdateInfoUserState) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 100,),
                            WidgetContainerImage(
                              height: MediaQuery.of(context).size.width*0.6,
                              width: MediaQuery.of(context).size.width*0.6,
                              image: IMAGES.LOGO_APP,
                            ),

                            SizedBox(height: 20,),
                            _buildButtonEnglish(state.infoUser),
                            SizedBox(height: 10,),
                            _buildButtonComming(state.infoUser),
                            SizedBox(height: 10,),
                            _buildButtonComming2(state.infoUser),
                          ],
                        ),
                      );

                    } else if (state is ErrorState) {
                      return Container(
                        child: Column(
                          children: [
                            TrailError(height: 250, width: 250),
                            Text(MESSAGES.CONNECT_ERROR, style: AppStyle.DEFAULT_MEDIUM),
                            AppValue.vSpaceSmall,
                            WidgetButton(
                              onTap: () => AppNavigator.navigateLogout(),
                              enable: true,
                              backgroundColor: COLORS.PRIMARY_COLOR,
                              text: MESSAGES.TRY,
                              width: 120,
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: TrailLoading(height: 150, width: 150),
                      );
                    }
                  }
              )
          ),
        ),
      ),
    );

  }

  _buildButtonComming(InfoUser infoUser) {
    List<String> listType = infoUser.type;
    return WidgetButtonHome(
      width: MediaQuery.of(context).size.width/1.4,
      height: 60,
      onTap: (){
        if(listType.contains('2') || listType.contains('4'))
          AppNavigator.navigateKnowledge();
        else
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return WidgetDialogDeveloping();
            },
          );

      },
      enable: true,
      backgroundColor: COLORS.WHITE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ICONS.TAX_ICON, height: 25,width: 25,),
          SizedBox(width: 10,),
          Text(MESSAGES.KNOWLEDGE,style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.PRIMARY_COLOR,fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 10,),
          listType.contains('2') || listType.contains('4') ? Container() : WidgetContainerImage(image: ICONS.LOCK_ICON, height: 20, width: 20,)
        ],
      ),
    );
  }

  _buildButtonComming2(InfoUser infoUser) {
    List<String> listType = infoUser.type;
    return WidgetButtonHome(
      width: MediaQuery.of(context).size.width/1.4,
      height: 60,
      onTap: (){
        if(listType.contains('3') || listType.contains('4'))
          AppNavigator.navigateTestMoneyActivity();
        else showDialog(
          context: context,
          builder: (BuildContext context) {
            return WidgetDialogDeveloping();
          },
        );
      },
      enable: true,
      backgroundColor: COLORS.WHITE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ICONS.FINANCE_ICON, height: 25,width: 25),
          SizedBox(width: 10,),
          Text(MESSAGES.KNOWLEDGE2,style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.PRIMARY_COLOR,fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 10,),
          listType.contains('3') || listType.contains('4') ? Container() : WidgetContainerImage(image: ICONS.LOCK_ICON, height: 20, width: 20,)
        ],
      ),
    );
  }

  _buildButtonEnglish(InfoUser infoUser) {
    List<String> listType = infoUser.type;

    return WidgetButtonHome(
      width: MediaQuery.of(context).size.width/1.4,
      height: 60,
      onTap: (){
        if(listType.contains('1') || listType.contains('4'))
          AppNavigator.navigateEnglish();

        else showDialog(
          context: context,
          builder: (BuildContext context) {
            return WidgetDialogDeveloping();
          },
        );
      },
      enable: true,
      backgroundColor: COLORS.WHITE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/english.png", height: 25,width: 25,),
          SizedBox(width: 10,),
          Text(MESSAGES.ENGLISH,style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.PRIMARY_COLOR,fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 10,),
          listType.contains('1') || listType.contains('4') ? Container() : WidgetContainerImage(image: ICONS.LOCK_ICON, height: 20, width: 20,)
        ],
      ),
    );
  }

  handleOnPressItemMenu(element){
    switch (element[PreferencesKey.TITLE]) {
      case MESSAGES.INFORMATION_ACCOUNT:
        _drawerKey.currentState!.openEndDrawer();
        AppNavigator.navigateInformationAccount();
        break;
      case MESSAGES.STATISTICAL:
        _drawerKey.currentState!.openEndDrawer();
        AppNavigator.navigateStatistical();
        break;
      case MESSAGES.NOTIFICATION:
        _drawerKey.currentState!.openEndDrawer();
        AppNavigator.navigateNotification();
        break;
      case MESSAGES.TERMS_POLICIES:
        _drawerKey.currentState!.openEndDrawer();
        AppNavigator.navigatePolicy();
        break;
      case MESSAGES.MANUAL:
        _drawerKey.currentState!.openEndDrawer();
        AppNavigator.navigateManual();
        break;
      case MESSAGES.ABOUT_US:
        _drawerKey.currentState!.openEndDrawer();
        AppNavigator.navigateAboutUs();
        break;
      default:
        break;
    }
  }
}
