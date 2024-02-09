import 'package:flutter/material.dart';

Future<IconData?> showIconPicker(
    {required BuildContext context, IconData? defalutIcon}) async {
  final List<IconData> allIcons = [
    Icons.favorite,
    Icons.star,
    Icons.volunteer_activism,
    Icons.medication,
    Icons.monitor_heart,
    Icons.games,
    Icons.videogame_asset,
    Icons.live_tv,
    Icons.ondemand_video,
    Icons.phone,
    Icons.phone_android,
    Icons.phone_iphone,
    Icons.support_agent,
    Icons.credit_card,
    Icons.health_and_safety,
    Icons.fitness_center,
    Icons.home,
    Icons.chair,
    Icons.shelves,
    Icons.crib,
    Icons.home_repair_service,
    Icons.countertops,
    Icons.cleaning_services,
    Icons.shower,
    Icons.electric_bolt,
    Icons.location_city,
    Icons.nightlife,
    Icons.hotel,
    Icons.directions_bus,
    Icons.train,
    Icons.local_taxi,
    Icons.local_airport,
    Icons.coffee,
    Icons.local_cafe,
    Icons.wine_bar,
    Icons.fastfood,
    Icons.lunch_dining,
    Icons.dinner_dining,
    Icons.delivery_dining,
    Icons.bakery_dining,
    Icons.icecream,
    Icons.sailing,
    Icons.attractions,
    Icons.stadium,
    Icons.directions_bike,
    Icons.directions_car,
    Icons.local_gas_station,
    Icons.local_movies,
    Icons.local_play,
    Icons.grass,
    Icons.sunny,
    Icons.nightlight,
    Icons.local_shipping,
    Icons.local_offer,
    Icons.shopping_bag,
    Icons.shopping_cart,
    Icons.dry_cleaning,
    Icons.checkroom,
    Icons.hardware,
    Icons.plumbing,
    Icons.carpenter,
    Icons.wind_power,
    Icons.build,
    Icons.local_fire_department,
    Icons.sos,
    Icons.store,
    Icons.storefront,
    Icons.cottage,
    Icons.apartment,
    Icons.business,
    Icons.business_center,
    Icons.spa,
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
                : Colors.grey.shade800,
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
