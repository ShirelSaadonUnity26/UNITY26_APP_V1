import 'package:flutter/material.dart';
import 'package:unity26_app_v1/screens/home/components/categories.dart';
import 'package:unity26_app_v1/screens/home/components/f.dart';
import 'package:unity26_app_v1/size_config.dart';
import 'home_header.dart';



class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You have to call SizeConfig on your starting page
    SizeConfig().init(context);
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: SafeArea(
        top: false,
        child: Column(
          children:  [
            HomeHeader(),
            const VerticalSpacing(),
            const Categories(),
            const F(),

          ],
        ),
      ),
    );
  }
}
