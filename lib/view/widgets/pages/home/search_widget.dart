import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onchange});
  final Function(String)? onchange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      onChanged: onchange,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        hintText: 'Search',
        hintStyle: TextStyle(
          fontFamily: 'Circular',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        filled: true,
        fillColor: secondaryCal,
        prefixIcon: Image.asset("assets/img/search.png", cacheHeight: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
