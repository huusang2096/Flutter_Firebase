import 'package:flutter/material.dart';
import 'package:flutter_app_chat/components/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CustomSurffixIcon extends StatelessWidget {

  final String svgIcon;

  const CustomSurffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        //getProportionateScreenWidth(10,),
        getProportionateScreenWidth(10,),
        getProportionateScreenWidth(10,),
        getProportionateScreenWidth(10,),
        getProportionateScreenWidth(10,),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(20,),
      ),
    );
  }
}
