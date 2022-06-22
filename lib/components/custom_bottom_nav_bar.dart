import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/screens/center_helper/center_helper_screen.dart';
import 'package:unity26_app_v1/size_config.dart';


class CustomBottonNavBar extends StatelessWidget {
  const CustomBottonNavBar({
    Key ? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem(
                icon: "assets/icons_new/sos1.svg",
                title: "סיוע",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CenterHelperScreen(),
                      ));
                },
              ),
              NavItem(
                icon: "assets/icons_new/calls.svg",
                title: "קריאות",
                isActive: true,
                press: () {},
              ),
              NavItem(
                icon: "assets/icons_new/profile.svg",
                title: "פרופיל",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
    this.isActive = false,
  }) : super(key: key);
  final String icon, title;
  final GestureTapCallback press;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: getProportionateScreenWidth(60),
        width: getProportionateScreenWidth(60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [if (isActive) kDefualtShadow],
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              color: kTextColor,
              height: 28,
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
