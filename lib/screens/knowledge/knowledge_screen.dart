
import 'package:english_quiz/widgets/widget_appbar_new.dart';
import 'package:english_quiz/widgets/widget_button_home.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

class   KnowledgeScreen extends StatefulWidget {
  @override
  _KnowledgeScreenState createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF79D0FE),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            WidgetBarNew(
              title: MESSAGES.KNOWLEDGE,
              backgroundColor: Color(0xFF79D0FE),

            ),
            Expanded(
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
                child: SingleChildScrollView(
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
                      _buildButtonTheory(),
                      SizedBox(height: 10,),
                      _buildButtonTest(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

  _buildButtonTheory() {
    return WidgetButtonHome(
      width: MediaQuery.of(context).size.width/2,
      height: 60,
      onTap: () => AppNavigator.navigateKnowledgeTest(),
      enable: true,
      backgroundColor: COLORS.WHITE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/test.png", height: 25,width: 25),
          SizedBox(width: 10,),
          Text(MESSAGES.TEST,style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.PRIMARY_COLOR,fontSize: 16, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
  _buildButtonTest() {
    return WidgetButtonHome(
      width: MediaQuery.of(context).size.width/1.5,
      height: 60,
      onTap: () => AppNavigator.navigateKnowledgeTheory(),
      enable: true,
      backgroundColor: COLORS.WHITE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/theory.png", height: 25,width: 25,),
          SizedBox(width: 10,),
          Text(MESSAGES.THEORY,style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.PRIMARY_COLOR,fontSize: 16, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

}