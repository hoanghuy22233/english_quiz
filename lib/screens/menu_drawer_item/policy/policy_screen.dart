// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PolicyScreen extends StatefulWidget {

  PolicyScreen({Key? key}) : super(key: key);

  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {

  @override
  void initState() {
    BlocProvider.of<PostBloc>(context).add(InitPostEvent(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: WidgetBackButton(),
          ),
          title: Text(MESSAGES.TERMS_POLICIES, style: AppStyle.DEFAULT_MEDIUM.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Container(
            color: COLORS.WHITE,
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state){
                        if(state is UpdatePostState){
                          final List<PostData>? data = state.dataPost;
                          if(data!.length == 0) return Center(child: Text(MESSAGES.NO_DATA, style: AppStyle.DEFAULT_MEDIUM_BOLD,));
                          else return Container(
                            padding: EdgeInsets.all(10),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return item(title: data[index].title, content: data[index].content);
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: TrailLoading(height: 100, width: 100),
                          );
                        }
                      }
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  item({required String title, required String content}){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyle.DEFAULT_MEDIUM_BOLD,),
          AppValue.vSpaceTiny,
          HtmlWidget(
            content,
          ),
          AppValue.vSpaceSmall,
        ],
      ),
    );
  }
}
