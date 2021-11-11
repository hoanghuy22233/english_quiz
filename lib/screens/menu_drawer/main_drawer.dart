import 'package:english_quiz/bloc/authen/authentication_bloc.dart';
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:english_quiz/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils_libs/utils_libs.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv; // ignore: import_of_legacy_library_into_null_safe

class MainDrawer extends StatelessWidget {
  final Function? onPress;

  const MainDrawer({this.onPress});

  @override
  Widget build(BuildContext context) {
    List _elements = [
      {
        'title': MESSAGES.INFORMATION_ACCOUNT,
        'image': ICONS.ICON_USER,
        'group': '1',
        'isAdmin': false
      },
      {
        'title': MESSAGES.STATISTICAL,
        'image': ICONS.ICON_CHART,
        'group': '1',
        'isAdmin': false
      },
      {
        'title': MESSAGES.NOTIFICATION,
        'image': ICONS.ICON_NOTIFICATION,
        'group': '1',
        'isAdmin': false
      },
      {
        'title': MESSAGES.TERMS_POLICIES,
        'image': ICONS.ICON_TERMS,
        'group': '1',
        'isAdmin': false
      },
      {
        'title': MESSAGES.MANUAL,
        'image': ICONS.ICON_MANUAL,
        'group': '1',
        'isAdmin': false,
      },
      {
        'title': MESSAGES.ABOUT_US,
        'image': ICONS.ABOUT_US,
        'group': '1',
        'isAdmin': false,
      },
    ];
    final bloc = AuthenticationBloc.of(context);
    return SafeArea(
      child: Container(
        width: AppValue.widths,
        height: AppValue.heights,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<InfoUserBloc, InfoUserState>(
                bloc: InfoUserBloc.of(context)..add(InitDataEvent())..add(AddDataEvent()),
                builder: (context, state) {
                  if (state is UpdateInfoUserState) {
                    return Container(
                      height: 140,
                      width: AppValue.widths,
                      padding: EdgeInsets.only(left: 15, top: 10),
                      decoration: BoxDecoration(
                          color: COLORS.PRIMARY_COLOR
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetAvatar(url: state.infoUser.image,height: 60,width: 60,),
                          AppValue.vSpaceTiny,
                          Container(
                            height: 20,
                            child: Text(
                              '${MESSAGES.HELLO} ${state.infoUser.name}',
                              softWrap: false,
                              textAlign: TextAlign.justify,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.DEFAULT_MEDIUM_BOLD.copyWith(color: COLORS.WHITE),
                            ),
                          ),
                          Container(
                            height: 20,
                            child: Text(
                              state.infoUser.email,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: AppStyle.DEFAULT_SMALLs.copyWith(color: COLORS.WHITE),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2),
                    );
                  }
                }
            ),
            Expanded(
                child: GroupedListView<dynamic, String>(
                  //elements: Handle.isArraysObject(_elements, state.role == 1 ? false : true),//check admin permission
                  elements: _elements,//check admin permission
                  groupBy: (element) => element['group'],
                  groupSeparatorBuilder: (String value) =>
                      WidgetLineContainer(),
                  itemBuilder: (c, element) => Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 7.0),
                    child: !element['isAdmin']
                        ? Column(
                      children: [
                        InkWell(
                          onTap: () => onPress!(element),
                          child: WidgetItemListMenu(
                            icon: element['image'],
                            title: element['title'],
                          ),
                        ),
                        AppValue.vSpaceSmall,
                      ],
                    )
                        : Container(),
                  ),
                )
            ),
            AppValue.vSpaceTiny,
            Center(
              child: InkWell(
                child: WidgetButton(
                  onTap: () async => bloc.add(AuthenticationLogoutRequested()),
                  backgroundColor: COLORS.RED,
                  width: 150,
                  height: 40,
                  text: MESSAGES.LOG_OUT,
                ),
              ),
            ),
            AppValue.vSpaceTiny,
          ],
        ),
      ),
    );
  }
}