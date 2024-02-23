import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  const SearchText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        hintText: "Search",
        suffixIcon:
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }
}
