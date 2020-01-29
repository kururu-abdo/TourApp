import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

const largTextSize =26.0;

const mediumTextSize =20.0;
const bodyTextStyle =16.0;

const String  defaultFont =ArabicFonts.Cairo;
const AppBarTextStyle= TextStyle(
  fontFamily: defaultFont ,
  fontStyle: FontStyle.italic ,
  fontWeight: FontWeight.w300 ,
  color: Colors.white ,
  fontSize: mediumTextSize
  );

const titleTextTheme= TextStyle(
  fontFamily: defaultFont ,
  fontStyle: FontStyle.italic ,
  fontWeight: FontWeight.w300 ,
  color: Colors.white ,
  fontSize: largTextSize
  );
const bright =Brightness.dark;
const bodyTextTheme= TextStyle(
  fontFamily: defaultFont ,
  fontStyle: FontStyle.italic ,
  fontWeight: FontWeight.w300 ,
  color: Colors.white ,
  fontSize: bodyTextStyle
  );
