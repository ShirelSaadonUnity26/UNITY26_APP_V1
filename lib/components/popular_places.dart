import 'package:flutter/material.dart';
import 'package:unity26_app_v1/components/place_card.dart';
import 'package:unity26_app_v1/components/section_title.dart';
import 'package:unity26_app_v1/models/TravelSpot.dart';
import 'package:unity26_app_v1/size_config.dart';

import '../constants.dart';


class PopularPlaces extends StatelessWidget {
  const PopularPlaces({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle( 
          title: "Right Now At Spark",
          press: () {},
        ),
        VerticalSpacing(of: 20),
        SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
              travelSpots.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(kDefaultPadding)),
                  child: PlaceCard(
                    travelSport: travelSpots[index],
                    press: () {},
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(kDefaultPadding),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
