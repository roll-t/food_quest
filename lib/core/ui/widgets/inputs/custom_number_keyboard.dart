import 'package:flutter/material.dart';

class CustomNumberKeyboard extends StatelessWidget {
  final TextEditingController controller;
  const CustomNumberKeyboard({super.key, required this.controller});

  void _addValue(String value) {
    final text = controller.text;
    controller.text = text + value;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: [
        for (var i = 1; i <= 9; i++)
          ElevatedButton(
            onPressed: () => _addValue(i.toString()),
            child: Text('$i'),
          ),
        ElevatedButton(
          onPressed: () => _addValue('000'), // ✅ nút 000
          child: const Text('000'),
        ),
        ElevatedButton(
          onPressed: () => _addValue('0'),
          child: const Text('0'),
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              controller.text =
                  controller.text.substring(0, controller.text.length - 1);
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            }
          },
          child: const Icon(Icons.backspace),
        ),
      ],
    );
  }
}
