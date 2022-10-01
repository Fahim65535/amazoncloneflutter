import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import '../widgets/barrel_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  double offset = 0;
  List<Widget>? discount50;
  List<Widget>? discount60;
  List<Widget>? discount70;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getDataa();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  //getting discounts of products from firebase to home screen
  void getDataa() async {
    List<Widget> temp50 = await CloudFirestore().getProductsFromDiscount(50);
    List<Widget> temp60 = await CloudFirestore().getProductsFromDiscount(60);
    List<Widget> temp70 = await CloudFirestore().getProductsFromDiscount(70);
    List<Widget> temp0 = await CloudFirestore().getProductsFromDiscount(0);

    setState(() {
      discount50 = temp50;
      discount60 = temp60;
      discount70 = temp70;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(isReadOnly: true, backButton: false),
        body: discount50 != null &&
                discount60 != null &&
                discount70 != null &&
                discount0 != null
            ? Stack(
                children: [
                  UserDetailsBar(offset: offset),
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        const SizedBox(height: kAppBarHeight / 2),
                        const CategoriesListView(),
                        const BannerAd(),
                        ProductShowcase(
                            title: 'Upto 70%', children: discount70!),
                        ProductShowcase(
                            title: 'Upto 60%', children: discount60!),
                        ProductShowcase(
                            title: 'Upto 50%', children: discount50!),
                        ProductShowcase(
                            title: 'Explore More', children: discount0!),
                      ],
                    ),
                  ),
                ],
              )
            : const LoadingIndicator());
  }
}
