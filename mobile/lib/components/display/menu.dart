import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

import '../../helpers/model.dart';
import 'image.dart';
import 'interaction.dart';

class MenuCard extends StatelessWidget {
  final MenuItem item;
  final void Function()? onTap;
  const MenuCard({super.key, required this.item, this.onTap});

  Widget buildCardBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name,
                style: Theme.of(context).textTheme.titleMedium),
        Text(item.harga,
            style: Theme.of(context).textTheme.labelSmall),
        Expanded(
          child: Text(item.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: OverInkwell(
        splashColor: Theme.of(context).colorScheme.onBackground,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: MaybeImage(
              url: item.img,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:  Container(
              constraints: const BoxConstraints.tightFor(height: 84.0),
              child: buildCardBody(context)
            )
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
        splashColor: COLOR_BRIGHT,
        titleAlignment: ListTileTitleAlignment.top,
        onTap: onTap,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.name,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(
                  item.harga,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            Text(item.description),
          ],
        ));
  }
}
