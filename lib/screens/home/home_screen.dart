// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/screens/screens.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? drawerKey;

  const HomeScreen({Key? key, this.drawerKey}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: AppValue.heights,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ContainerHeader(
              drawerKey: widget.drawerKey,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    WidgetContainerImage(
                      height: 150,
                      width: 150,
                      image: IMAGES.LOGO_APP,
                    ),

                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }



}