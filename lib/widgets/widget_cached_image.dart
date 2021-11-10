import 'package:cached_network_image/cached_network_image.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http; // ignore: import_of_legacy_library_into_null_safe

class WidgetCachedImage extends StatelessWidget {
  WidgetCachedImage({this.url, this.color, this.fit, this.icon, this.height, this.width, this.borderRadius});
  final String? url, icon;
  final Color? color;
  final BoxFit? fit;
  final double? height, width;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: url ?? IMAGES.LOGO_APP,
          placeholder: (context, url) => Center(
            child: TrailLoading(height: 100, width: 100),
          ),
          errorWidget: (context, url, error) => Center(child: Icon(Icons.info)),
          color: color,
          fit: fit ?? AppValue.IMAGE_FIT_MODE,
          filterQuality: FilterQuality.low,
        ),
      ),
    );
  }
}

class WidgetAvatar extends StatelessWidget {
  final String? url;
  final double? height, width;
  WidgetAvatar({this.url, this.height = 100, this.width = 100});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: url ?? IMAGES.LOGO_APP,
            height: height,
            width: width,
            fit: BoxFit.fill,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => WidgetContainerImage(image: IMAGES.LOGO_APP, height: 100, width: 100,),
          ),
        ),
      ),
    );
  }
}

class WidgetImageCircle extends StatelessWidget {
  final String? url;
  final double height, width;
  WidgetImageCircle({this.url, this.height = 70, this.width = 70});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: url ?? IMAGES.LOGO_APP,
            fit: BoxFit.fill,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => WidgetContainerImage(image: IMAGES.LOGO_APP),
          ),
        ),
      ),
    );
  }
}