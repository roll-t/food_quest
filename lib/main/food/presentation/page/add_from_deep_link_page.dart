import 'package:flutter/material.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/main/food/presentation/widgets/add_food_widget.dart';

class AddFromDeepLinkPage extends CustomState {
  const AddFromDeepLinkPage({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: AddFoodWidget(),
        ),
      ],
    );
  }
}
