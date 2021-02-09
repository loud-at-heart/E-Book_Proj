import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gutenberg_project/Widgets/genreCard.dart';
import 'package:gutenberg_project/Constants.dart';

class MyMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F7FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    width: double.infinity,
                    // color: Colors.amber,
                    child: SvgPicture.asset(
                      "assets/images/Pattern.svg",
                      fit: BoxFit.cover,
                      height: 350,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Gutenberg',
                          style: kHeadingOne,
                        ),
                        Text(
                          'Project',
                          style: kHeadingOne,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          kDesc,
                          maxLines: 3,
                          style: kBody,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: genre.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GenreCard(category: genre[index],);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
