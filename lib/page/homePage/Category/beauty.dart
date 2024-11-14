import 'package:flutter/material.dart';
import 'package:shop/page/homePage/Category/feature.dart';
import 'package:shop/page/homePage/Category/recommend.dart';
import 'package:shop/page/homePage/Category/topCollection.dart';

class Beauty extends StatelessWidget {
  const Beauty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/poster.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const FeatureProducts(),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/banner.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const Recommend(),
        const TopCollectionPage(),
      ],
    );
  }
}
