import 'package:amazone_clone_app/screens/barrel_screens.dart';
import '../config/barrel_config.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool backButton;
  SearchBar({
    Key? key,
    required this.isReadOnly,
    required this.backButton,
  })  : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey, width: 1));

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: kAppBarHeight * 90,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          backButton
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                )
              : Container(),
          SizedBox(
            width: screenSize.width * 0.75,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextFormField(
                onFieldSubmitted: (String query) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ResultScreen(query: query);
                      },
                    ),
                  );
                },
                readOnly: isReadOnly,
                onTap: () {
                  if (isReadOnly) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ));
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search Amazon',
                  fillColor: Colors.white,
                  filled: true,
                  border: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mic_none_outlined,
              ))
        ],
      ),
    );
  }
}
