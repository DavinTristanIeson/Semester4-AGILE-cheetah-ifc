import 'package:flutter/material.dart';

import 'constants.dart';

final BUTTON_PRIMARY = ElevatedButton.styleFrom(
  backgroundColor: COLOR_PRIMARY,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  textStyle: TEXT_IMPORTANT,
  disabledBackgroundColor: COLOR_PRIMARY_DARK,
  disabledForegroundColor: COLOR_PRIMARY_DARK,
);

final BUTTON_SECONDARY = ElevatedButton.styleFrom(
  backgroundColor: COLOR_SECONDARY,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  disabledBackgroundColor: COLOR_SECONDARY_DARK,
  disabledForegroundColor: COLOR_SECONDARY_DARK,
);


const TEXT_DEFAULT = TextStyle(
  fontSize: FS_DEFAULT,
);

const TEXT_SEMIBOLD = TextStyle(
  fontSize: FS_DEFAULT,
  fontWeight: FontWeight.w500
);

const TEXT_IMPORTANT = TextStyle(
  color: Colors.black,
  fontSize: FS_EMPHASIS,
  fontWeight: FontWeight.bold,
  fontFamily: 'Josefin Sans',
);

const TEXT_LINK = TextStyle(
  color: Colors.black,
  fontSize: FS_EMPHASIS,
  fontWeight: FontWeight.bold,
  fontFamily: 'Josefin Sans',
);

const TEXT_TITLE = TextStyle(
  color: Colors.black,
  fontSize: FS_LARGE,
  fontWeight: FontWeight.bold,
  fontFamily: 'Josefin Sans',
);

const TEXT_ITEM_TITLE = TextStyle(
  fontSize: FS_EMPHASIS,
  fontWeight: FontWeight.bold,
  fontFamily: 'Josefin Sans',
);

const TEXT_SMALL_DETAIL = TextStyle(
  fontSize: FS_SMALL,
  fontWeight: FontWeight.w300,
  color: COLOR_DARK,
);

const TEXT_DETAIL = TextStyle(
  fontSize: FS_DEFAULT,
  fontWeight: FontWeight.w400,
  color: COLOR_DARK,
);

const TEXT_HIGHLIGHT = TextStyle(
  fontSize: FS_EMPHASIS,
  fontWeight: FontWeight.w500,
  color: COLOR_PRIMARY,
);


const TEXT_INPUT_ERROR = TextStyle(
  color: COLOR_ERROR,
  fontSize: FS_SMALL,
);