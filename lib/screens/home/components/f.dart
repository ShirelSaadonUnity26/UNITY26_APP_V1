import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';
import 'package:unity26_app_v1/size_config.dart';

class F extends StatelessWidget {
  const F({
    Key ? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons_new/animal.svg", "text": "בעלי חיים"},
      {"icon": "assets/icons_new/stealing.svg", "text": "גניבות"},
      {"icon": "assets/icons_new/group.svg", "text": "קבוצות אישיות"},
    ];

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
              (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {

            },
          ),
        ),

      ),

    );
  }
}




class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(75),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SvgPicture.asset(icon!),

            ),
            const SizedBox(height: 5),

            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}