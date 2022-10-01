import '../screens/barrel_screens.dart';
import 'package:flutter/material.dart';

const double kAppBarHeight = 90;

const String amazonLogoUrl =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Amazon_icon.svg/2500px-Amazon_icon.svg.png";

const List<String> categoriesList = [
  "Prime",
  "Mobiles",
  "Fashion",
  "Electronics",
  "Home",
  "Fresh",
  "Appliances",
  "Books, Toys",
  "Essential"
];

const List<Widget> screens = [
  HomeScreen(),
  AccountScreen(),
  CartScreen(),
  MenuScreeen(),
];

const List<String> categoryLogos = [
  "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11qyfRJvEbL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11BIyKooluL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11CR97WoieL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/01cPTp7SLWL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11yLyO9f9ZL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
];

const List<String> largeAds = [
  "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61jmYNrfVoL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/612a5cTzBiL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61fiSvze0eL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61PzxXMH-0L._SX3000_.jpg",
];

const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> adItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];

//Dont even attemp to scroll to the end of this manually lmao
const String amazonLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png";

//list of products
// List<Widget> childrenList = [
//   SimpleProductList(
//     productModel: ProductModel(
//       cost: 999.99,
//       discount: 20,
//       noOfRating: 1,
//       productName: '2-seat black leather couch',
//       rating: 3,
//       sellarName: 'Seller Name',
//       // sellerUid: 'xxxxxxxxxx',
//       uid: 'xxxxxxxx',
//       url:
//           'https://www.ikea.com/gb/en/images/products/vimle-2-seat-sofa-grann-bomstad-black__0817321_pe773961_s5.jpg?f=s',
//     ),
//   ),
//   SimpleProductList(
//     productModel: ProductModel(
//       cost: 534.65,
//       discount: 20,
//       noOfRating: 6,
//       productName: 'Dining table',
//       rating: 4,
//       sellarName: 'Seller Name',
//       // sellerUid: 'xxxxxxxxxx',
//       uid: 'xxxxxxxx',
//       url:
//           'https://www.ikea.com/gb/en/images/products/jokkmokk-table-and-4-chairs-antique-stain__0736929_pe740809_s5.jpg?f=s',
//     ),
//   ),
//   SimpleProductList(
//     productModel: ProductModel(
//       cost: 999.99,
//       discount: 20,
//       noOfRating: 1,
//       productName: '2-seat black leather couch',
//       rating: 3,
//       sellarName: 'Seller Name',
//       // sellerUid: 'xxxxxxxxxx',
//       uid: 'xxxxxxxx',
//       url:
//           'https://www.ikea.com/gb/en/images/products/vimle-2-seat-sofa-grann-bomstad-black__0817321_pe773961_s5.jpg?f=s',
//     ),
//   ),
//   SimpleProductList(
//     productModel: ProductModel(
//       cost: 999.99,
//       discount: 20,
//       noOfRating: 1,
//       productName: '2-seat black leather couch',
//       rating: 3,
//       sellarName: 'Seller Name',
//       // sellerUid: 'xxxxxxxxxx',
//       uid: 'xxxxxxxx',
//       url:
//           'https://www.ikea.com/gb/en/images/products/vimle-2-seat-sofa-grann-bomstad-black__0817321_pe773961_s5.jpg?f=s',
//     ),
//   ),
//   SimpleProductList(
//     productModel: ProductModel(
//       cost: 999.99,
//       discount: 20,
//       noOfRating: 1,
//       productName: '2-seat black leather couch',
//       rating: 3,
//       sellarName: 'Seller Name',
//       // sellerUid: 'xxxxxxxxxx',
//       uid: 'xxxxxxxx',
//       url:
//           'https://www.ikea.com/gb/en/images/products/vimle-2-seat-sofa-grann-bomstad-black__0817321_pe773961_s5.jpg?f=s',
//     ),
//   ),
// ];

List<String> ratingScale = [
  'Very Bad',
  'Poor',
  'Average',
  'Good',
  'Excellent',
];
