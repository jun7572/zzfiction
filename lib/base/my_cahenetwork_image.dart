import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zzfiction/base/request.dart';
import 'package:zzfiction/gen_a/A.dart';

class MyCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final bool withHostName;

  const MyCachedNetworkImage({Key key, this.imageUrl,this.withHostName=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      memCacheWidth: 120,
      width: 120,
      height: 170,
      imageUrl: withHostName?RequestUtil.SERVER_API_URL+imageUrl:imageUrl,
      placeholder: (_, __) => Image.asset(A.assets_doglogo),
      errorWidget: (_, __, ___) =>
          Image.asset(A.assets_doglogo),
      fit: BoxFit.cover,
    );
  }
}
