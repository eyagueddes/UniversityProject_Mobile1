import 'package:flutter/material.dart';

import '../../components/search_bar.dart';
class update_profile extends StatefulWidget {
  const update_profile({Key? key}) : super(key: key);

  @override
  State<update_profile> createState() => _update_profileState();
}

class _update_profileState extends State<update_profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: search_bar(),
    );

  }
}
