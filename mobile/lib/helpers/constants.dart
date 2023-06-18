import 'package:flutter/material.dart';

const String BACKEND_HOST = "localhost:3000";
const String BACKEND = "http://localhost:3000";
const String API = "http://localhost:3000/api";
const String BACKGROUND_IMAGE_PATH =
    "assets/images/pexels-igor-starkov-1307698.jpg";
const String FALLBACK_IMAGE_PATH = "assets/images/image-not-available.jpg";
const String LOGO_PATH = "assets/images/logo.svg";

// Errors
const String CONNECTION_ERROR =
    "Maaf, kita tidak dapat berhubung dengan server pada saat ini. Mohon dicoba pada waktu lain.";
const String SERVER_ERROR =
    "Maaf, terjadi kesalahan di bagian server. Mohon dicoba di waktu lain.";
const String UNEXPECTED_ERROR =
    "Maaf, terjadi kesalahan yang tidak diduga. Mohon dicoba di waktu lain";
const String NO_DATA = "Kami tidak dapat menemukan data apapun";

const Color COLOR_PRIMARY = Color(0xFFB99878);
const Color COLOR_PRIMARY_DARK = Color.fromARGB(255, 133, 105, 78);
const Color COLOR_SECONDARY = Color(0xFFEBE6DD);
const Color COLOR_SECONDARY_DARK = Color.fromARGB(255, 210, 198, 176);
const Color COLOR_TERTIARY = Colors.grey;
const Color COLOR_DARK = Color(0xFF523112);
const Color COLOR_BRIGHT = Color(0xFFFFFBF4);
const Color COLOR_ERROR = Color(0xFFDC3545);
const Color COLOR_ERROR_CONTAINER = Color.fromARGB(255, 217, 83, 96);
const Color COLOR_SHADOW = Color.fromRGBO(0, 0, 0, 0.1);
const Color COLOR_SUCCESS = Colors.green;
const Color COLOR_SUCCESS_CONTAINER = Color.fromARGB(255, 163, 223, 165);

const double GAP_SM = 4.0;
const double GAP = 8.0;
const double GAP_LG = 16.0;

const BoxShadow SOLID_SHADOW = BoxShadow(
    spreadRadius: GAP_SM, offset: Offset(0.2, 0.2), color: COLOR_SHADOW);

const double FS_SMALL = 10.0;
const double FS_DEFAULT = 13.0;
const double FS_EMPHASIS = 16.0;
const double FS_LARGE = 20.0;

const String FONT = "JosefinSans";