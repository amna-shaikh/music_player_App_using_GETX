


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player_app/consts/colors.dart';
const bold = "bold";
const regular = "regular";

textstyle({family = regular , color = whitecolor ,double? size = 18 }){
 return  TextStyle(
      fontSize: size,
      color:color,
      fontFamily: family
  );
}