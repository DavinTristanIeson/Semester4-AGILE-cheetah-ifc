import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

import '../../helpers/model.dart';
import '../../helpers/styles.dart';
import 'image.dart';
import 'interaction.dart';

/* Pertemuan 12
- Card */
class MenuCard extends StatelessWidget {
  final MenuItem item;
  final void Function()? onTap;
  const MenuCard({super.key, required this.item, this.onTap});

  Widget buildCardBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name, style: TEXT_ITEM_TITLE),
        Text(item.harga, style: TEXT_DETAIL),
        Expanded(
          child: Text(item.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TEXT_DEFAULT,
          )
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: COLOR_SECONDARY,
      child: OverInkwell(
        splashColor: COLOR_BRIGHT,
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

/* Pertemuan 12
- List Tile */
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
                  style: TEXT_ITEM_TITLE),
              Text(
                item.harga,
                style: TEXT_SMALL_DETAIL
              )
            ],
          ),
          Text(item.description),
        ],
      ));
  }
}