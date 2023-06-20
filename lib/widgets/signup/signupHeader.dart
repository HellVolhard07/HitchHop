import 'package:flutter/material.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(image),
          height: mq.height * 0.2,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
