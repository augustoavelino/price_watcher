import 'package:flutter/material.dart';

Future<Color?> showColorPicker(
    {required BuildContext context, Color? defaultColor}) async {
  final List<Color> allColors = [
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.red,
    Colors.pink,
  ];

  Color? selectedColor = defaultColor;

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Pick a color'),
      content: Container(
        width: 264,
        height: 264,
        alignment: Alignment.center,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 60,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: allColors.length,
          itemBuilder: (_, index) => Container(
            key: ValueKey(allColors[index].value),
            padding: const EdgeInsets.all(4),
            child: Center(
              child: OutlinedButton(
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const MaterialStatePropertyAll(CircleBorder()),
                  side: const MaterialStatePropertyAll(BorderSide.none),
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
                  backgroundColor: MaterialStatePropertyAll(
                      allColors[index] == selectedColor
                          ? Colors.lightBlue
                          : null),
                ),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 4,
                      color: Colors.white,
                    ),
                    color: allColors[index],
                  ),
                ),
                onPressed: () {
                  selectedColor = allColors[index];
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        )
      ],
    ),
  );

  return selectedColor;
}
