import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormError extends StatelessWidget {

  final List<String> errors;

  const FormError({Key key, this.errors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
        List.generate(
          errors.length, (index) => rowFormText(error: errors[index]),
        ),
    );
  }

  Row rowFormText({String error}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset("assets/icons/Error.svg",height: 14,width: 14,),
        SizedBox(width: 10,),
        Text(error),
      ],
    );
  }

}
