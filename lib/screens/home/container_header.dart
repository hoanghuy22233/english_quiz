import 'package:flutter/material.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe

class ContainerHeader extends StatefulWidget {
  final GlobalKey<ScaffoldState>? drawerKey;
  ContainerHeader({Key? key, this.drawerKey});

  @override
  _ContainerHeaderState createState() => _ContainerHeaderState();
}

class _ContainerHeaderState extends State<ContainerHeader> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => widget.drawerKey!.currentState!.openDrawer(),
            child: WidgetContainerImage(
              image: ICONS.MENU,
              colorImage: COLORS.WHITE,
            )
          ),
          AppValue.hSpaceSmall,
          Center(
            child: Text(MESSAGES.APP_TITLE, style: AppStyle.DEFAULT_LARGE_BOLD.copyWith(color: COLORS.WHITE),),
          ),
        ],
      ),
    );
  }
}
