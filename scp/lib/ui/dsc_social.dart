import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Widget dscSocial() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
          icon: FaIcon(FontAwesomeIcons.globe),
          onPressed: () {
            launchURL('https://dscnitrourkela.org');
          }),
      IconButton(
          icon: FaIcon(FontAwesomeIcons.github),
          onPressed: () {
            launchURL('https://github.com/dscnitrourkela');
          }),
      IconButton(
          icon: FaIcon(FontAwesomeIcons.medium),
          onPressed: () {
            launchURL('https://medium.com/dsc-nit-rourkela');
          }),
      IconButton(
          icon: FaIcon(FontAwesomeIcons.linkedin),
          onPressed: () {
            launchURL('https://www.linkedin.com/company/dscnitrourkela');
          }),
      IconButton(
          icon: FaIcon(FontAwesomeIcons.facebook),
          onPressed: () {
            launchURL('https://www.facebook.com/dscnitrourkela');
          }),
      IconButton(
          icon: FaIcon(FontAwesomeIcons.instagram),
          onPressed: () {
            launchURL('https://www.instagram.com/dscnitrourkela');
          }),
      IconButton(
          icon: FaIcon(FontAwesomeIcons.twitter),
          onPressed: () {
            launchURL('https://twitter.com/dscnitrourkela');
          }),
    ],
  );
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
