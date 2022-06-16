// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutUsScreen extends StatefulWidget {

  AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  // @override
  // void initState() {
  //   BlocProvider.of<PostBloc>(context).add(InitPostEvent(3));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: WidgetBackButton(),
          ),
          title: Text(MESSAGES.ABOUT_US, style: AppStyle.DEFAULT_MEDIUM.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Container(
            color: COLORS.WHITE,
            child: item(
              content: 'Nội dung kiến thức được xây dựng vởi Nguyễn Hoài Sơn và Tổ Giáo Viên ôn thi Thuế - Kho Bạc nhà nước.\nLiên Hệ: Nguyễn Hoài Sơn\nĐT: (024)23.225.999\nZalo: 0933.130.883\nFacebook: Sơn Andy, ÔN THI CÔNG CHỨC THUẾ - KHO BẠC NHÀ NƯỚC', title: 'Về chúng tôi'
            ),
          ),
        )
    );
  }

  item({required String title, required String content}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyle.DEFAULT_MEDIUM_BOLD,),
          AppValue.vSpaceTiny,
          Text(
            content,
            style: AppStyle.DEFAULT_MEDIUM,
            textAlign: TextAlign.justify,
          ),

          GestureDetector(
            onTap: (){
              _openUrl("https://www.facebook.com/andy.tom.14");
            },
            child: Text("https://www.facebook.com/andy.tom.14",style: AppStyle.DEFAULT_MEDIUM_LINK,),
          ),
          GestureDetector(
            onTap: (){
              _openUrl("https://www.facebook.com/groups/2980473688659274");
            },
            child: Text("https://www.facebook.com/groups/2980473688659274",style: AppStyle.DEFAULT_MEDIUM_LINK,),

          ),
          AppValue.vSpaceSmall,

        ],
      ),
    );
  }
}
_openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}