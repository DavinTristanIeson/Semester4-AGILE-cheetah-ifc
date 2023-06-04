import 'package:flutter/material.dart';

import 'constants.dart';

final BUTTON_PRIMARY = ElevatedButton.styleFrom(
  backgroundColor: COLOR_PRIMARY,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  disabledBackgroundColor: COLOR_PRIMARY_DARK,
  disabledForegroundColor: COLOR_PRIMARY_DARK,
);

const TEXT_IMPORTANT = TextStyle(
  color: Colors.black,
  fontSize: FS_EMPHASIS,
  fontWeight: FontWeight.bold,
);

const TEXT_INPUT_ERROR = TextStyle(
  color: COLOR_ERROR,
  fontSize: FS_SMALL,
);