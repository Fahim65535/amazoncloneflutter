import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;

  const UserDetailsBar({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    UserDetails userDetail =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Positioned(
      top: -offset / 4,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: lightBackgroundaGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.black),
              const SizedBox(width: 6),
              SizedBox(
                width: screenSize.width * 0.8,
                child: Text(
                  'Deliver to ${userDetail.name} - ${userDetail.address}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[900]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
