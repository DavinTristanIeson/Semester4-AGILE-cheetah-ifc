import 'package:flutter/material.dart';

import '../../helpers/model.dart';
import 'image.dart';

class MenuCard extends StatelessWidget {
  final MenuItem item;
  final void Function()? onTap;
  const MenuCard({super.key, required this.item, this.onTap});

  Widget buildCardBody(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              )),
          Text(item.harga,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ))
        ],
      ),
      Text(item.description,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primary,
        onTap: onTap,
        child: Column(children: [
          MaybeImage(url: item.img),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: buildCardBody(context),
          )
        ]),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final MenuItem item;
  final void Function()? onTap;
  const MenuListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        onTap: onTap,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  item.harga,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
            Text(item.description),
          ],
        ));
  }
}
