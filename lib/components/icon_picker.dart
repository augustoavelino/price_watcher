import 'package:flutter/material.dart';

Future<IconData?> showIconPicker(
    {required BuildContext context, IconData? defalutIcon}) async {
  final List<IconData> allIcons = [
    Icons.card_giftcard,
    Icons.card_membership,
    Icons.credit_card,
    Icons.credit_score,
    Icons.diamond,
    Icons.umbrella_sharp,
    Icons.favorite,
    Icons.headphones,
    Icons.home,
    Icons.car_repair,
    Icons.settings,
    Icons.flight,
    Icons.ac_unit,
    Icons.run_circle,
    Icons.book,
    Icons.sports_rugby_rounded,
    Icons.alarm,
    Icons.call,
    Icons.snowing,
    Icons.hearing,
    Icons.music_note,
    Icons.note,
    Icons.edit,
    Icons.sunny,
    Icons.radar,
  ];

  // selected icon
  // the selected icon is highlighed
  // so it looks different from the others
  IconData? selectedIcon = defalutIcon;

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Pick an icon'),
      content: Container(
        width: 320,
        height: 400,
        alignment: Alignment.center,
        // This grid view displays all selectable icons
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 60,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: allIcons.length,
          itemBuilder: (_, index) => IconButton(
            key: ValueKey(allIcons[index].codePoint),
            // give the selected icon a different color
            padding: const EdgeInsets.all(8),
            color: selectedIcon == allIcons[index]
                ? Colors.lightBlue
                : Colors.grey.shade900,
            iconSize: 32,
            icon: Icon(
              allIcons[index],
            ),
            onPressed: () {
              selectedIcon = allIcons[index];
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );

  return selectedIcon;
}
