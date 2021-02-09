import 'package:flutter/material.dart';
import 'package:gutenberg_project/Screens/home.dart';
import 'package:gutenberg_project/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookAppBar extends StatelessWidget {
  BookAppBar({Key key, this.title}) : super(key: key);
  String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          child: SvgPicture.asset(
            'assets/images/Back.svg',
            height: 20.0,
            width: 20.0,
          ),
          onTap: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MyMainPage()));
          },),
        SizedBox(width: 10.0,),
        Text(
          title,
          style: kHeadingTwo,
        )
      ],
    );
  }
}
