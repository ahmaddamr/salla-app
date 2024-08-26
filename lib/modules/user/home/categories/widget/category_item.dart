import 'package:flutter/material.dart';
import 'package:salla_app/core/utils_class.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.img, required this.text});
  final String img;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(
                  img,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                text,
                style: Styles.onboardingSubTitle,
                textAlign: TextAlign.start,
              ),
              const Spacer(
                flex: 5,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_sharp))
            ],
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
