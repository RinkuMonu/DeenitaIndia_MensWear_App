// import 'package:deenitaindia/constants/colors.dart';
// import 'package:deenitaindia/view/wishlistScreen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../constants/image.dart';
// import '../controller/productDetailController.dart';
// import '../widgets/customAppBar.dart';
// import 'cart.dart';
//
// class ProductDetailScreen extends StatefulWidget {
//   ProductDetailScreen({super.key});
//
//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }
//
// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   final controller = Get.put(ProductDetailController());
//
//   // ── Dummy data ──────────────────────────────────────────────────────────────
//
//   final List<Map<String, dynamic>> _reviews = [
//     {
//       'name': 'Wade Warren',
//       'rating': 4.5,
//       'time': '6 days ago',
//       'comment': 'The item is very good, my son likes it very much and plays every day.'
//     },
//     {
//       'name': 'Guy Hawkins',
//       'rating': 4.5,
//       'time': '1 week ago',
//       'comment': 'The seller is very fast in sending packet. I just bought it and already arrived in just 1 day.'
//     },
//     {
//       'name': 'Robert Fox',
//       'rating': 4.5,
//       'time': '2 weeks ago',
//       'comment': 'I just bought it and the stuff is really good! I highly recommend it.'
//     },
//   ];
//
//   final List<Map<String, dynamic>> _ratingBreakdown = [
//     {'stars': 5, 'count': 703, 'label': 'Very Good(703)'},
//     {'stars': 4, 'count': 634, 'label': 'Good(634)'},
//     {'stars': 3, 'count': 40,  'label': 'Ok (40)'},
//     {'stars': 2, 'count': 10,  'label': 'Bad(10)'},
//     {'stars': 1, 'count': 5,   'label': 'Very Bad(5)'},
//   ];
//
//   final List<String> _similarProducts = [
//     'https://images.unsplash.com/photo-1620012253295-c15cc3e65df4?w=200',
//     'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=200',
//     'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=200',
//   ];
//
//   final List<Map<String, dynamic>> _youMayAlsoLike = [
//     {'img': 'https://images.unsplash.com/photo-1620012253295-c15cc3e65df4?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': false},
//     {'img': 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '30% OFF', 'wishlisted': false},
//     {'img': 'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': true},
//     {'img': 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,300', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': false},
//     {'img': 'https://images.unsplash.com/photo-1523381294911-8d3cead13475?w=200', 'brand': 'Polo', 'type': 'BROWN S-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '20% OFF', 'wishlisted': false},
//     {'img': 'https://images.unsplash.com/photo-1503341504253-dff4815485f1?w=200', 'brand': 'Polo', 'type': 'BROWN S-SHIRT', 'price': 'Rs.1,300', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': false},
//     {'img': 'https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '90% OFF', 'wishlisted': false},
//     {'img': 'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=200', 'brand': 'Polo', 'type': 'BROWN S-SHIRT', 'price': 'Rs.1,300', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': false},
//   ];
//
//   // ── Helpers ─────────────────────────────────────────────────────────────────
//
//   Widget _starRow(double rating, {double size = 16, Color color = Colors.amber}) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (i) {
//         if (i < rating.floor()) return Icon(Icons.star, size: size, color: color);
//         if (i < rating) return Icon(Icons.star_half, size: size, color: color);
//         return Icon(Icons.star_border, size: size, color: color);
//       }),
//     );
//   }
//
//   // ── Build ────────────────────────────────────────────────────────────────────
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//         title: Container(
//           height: 40,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.grey.shade200),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: TextField(
//             style: const TextStyle(fontSize: 12, color: Colors.black),
//             onChanged: (value) => print("Search: $value"),
//             decoration: InputDecoration(
//               hintText: "Search products...",
//               hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
//               border: InputBorder.none,
//               prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
//               contentPadding: const EdgeInsets.symmetric(vertical: 10),
//             ),
//           ),
//         ),
//         actions: [
//           topIcons(icon: AppImage.fav, onIconTap: () => Get.to(() => WishlistScreen())),
//           const SizedBox(width: 8),
//           topIcons(icon: AppImage.shoppingBag, onIconTap: () => Get.to(() => CartView())),
//         ],
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             // ── Brand banner ────────────────────────────────────────────────
//             Container(
//               decoration: const BoxDecoration(color: AppColors.yellow_shade),
//               child: Row(
//                 children: [
//                   Image.network(
//                     "https://t3.ftcdn.net/jpg/03/34/79/68/360_F_334796865_VVTjg49nbLgQPG6rgKDjVqSb5XUhBVsW.jpg",
//                     height: 80, width: 80, fit: BoxFit.cover,
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text("Rare Rabbit", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
//                       Text("Men Olive Regular", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 12)),
//                     ],
//                   ),
//                   const Spacer(),
//                   Row(
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Row(
//                             children: const [
//                               Text("Rs.1,100", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18)),
//                               SizedBox(width: 8),
//                               Text("1,500", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 13, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey)),
//                             ],
//                           ),
//                           const Text("10% OFF", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 12)),
//                         ],
//                       ),
//                       const SizedBox(width: 4),
//                       const Icon(Icons.chevron_right, color: Colors.black54, size: 24),
//                     ],
//                   ),
//                   const SizedBox(width: 8),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // ── Main image ──────────────────────────────────────────────────
//             Stack(
//               children: [
//                 Obx(() => Image.network(
//                   controller.images[controller.selectedImageIndex.value],
//                   width: double.infinity,
//                   height: size.height * 0.4,
//                   fit: BoxFit.cover,
//                 )),
//                 Positioned(
//                   top: 12, right: 12,
//                   child: Obx(() => _iconButton(
//                     icon: controller.isSelected.value ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
//                     color: controller.isSelected.value ? Colors.pinkAccent : Colors.black,
//                     onTap: controller.isSelected.toggle,
//                   )),
//                 ),
//                 Positioned(
//                   top: 70, right: 12,
//                   child: _iconButton(icon: CupertinoIcons.cart, onTap: () {}),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             // ── Thumbnails ──────────────────────────────────────────────────
//             SizedBox(
//               height: 90,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: controller.images.length,
//                 itemBuilder: (context, index) => Obx(() {
//                   final isSelected = controller.selectedImageIndex.value == index;
//                   return GestureDetector(
//                     onTap: () => controller.changeImage(index),
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: isSelected ? Colors.black : Colors.grey.shade300,
//                           width: 1,
//                         ),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(controller.images[index], width: 70, height: 70, fit: BoxFit.cover),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // ── Product title ───────────────────────────────────────────────
//             const Text(
//               "Lionies Gija Cotton Slim Fit Self-Design Off Pink Party Shirt",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
//             ),
//
//             const SizedBox(height: 16),
//
//             // ── Size selector ───────────────────────────────────────────────
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text("Choose Size", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black)),
//                 Text("Size Chart", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey)),
//               ],
//             ),
//
//             const SizedBox(height: 8),
//
//             SizedBox(
//               height: 40,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: controller.sizes.length,
//                 itemBuilder: (context, index) => Obx(() {
//                   final isSelected = controller.selectedsizeIndex.value == index;
//                   return GestureDetector(
//                     onTap: () => controller.changeSize(index),
//                     child: Container(
//                       alignment: Alignment.center,
//                       width: 50,
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: isSelected ? AppColors.yellow_shade : Colors.white,
//                         border: Border.all(color: isSelected ? Colors.black : Colors.grey.shade300),
//                       ),
//                       child: Text(controller.sizes[index], style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // ── Quantity ────────────────────────────────────────────────────
//             const Text("Quantity", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black)),
//
//             const SizedBox(height: 12),
//
//             Obx(() => Row(
//               children: [
//                 _qtyButton(icon: CupertinoIcons.minus, onTap: () => controller.decreaseQty(controller.count.value)),
//                 const SizedBox(width: 12),
//                 Text(controller.count.value.toString()),
//                 const SizedBox(width: 12),
//                 _qtyButton(icon: Icons.add, onTap: () => controller.increaseQty(controller.count.value)),
//               ],
//             )),
//
//             const SizedBox(height: 20),
//
//             // ── Delivery badge + Buy row ─────────────────────────────────────
//             Row(
//               children: [
//                 const Icon(Icons.electric_bolt, color: Colors.amber, size: 16),
//                 const SizedBox(width: 4),
//                 const Text("30mins Dilivev", style: TextStyle(fontSize: 13, color: Colors.grey)),
//               ],
//             ),
//
//             const SizedBox(height: 10),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.baseline,
//                   textBaseline: TextBaseline.alphabetic,
//                   children: const [
//                     Text("Rs.1,100", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)),
//                     SizedBox(width: 8),
//                     Text("1,500", style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey)),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 44,
//                   width: 140,
//                   child: ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: SvgPicture.asset(AppImage.shoppingBag, color: Colors.white,),
//                     label: const Text("Buy", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.secondary,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 24),
//
//             // ── Ratings ─────────────────────────────────────────────────────
//             const Divider(),
//             const SizedBox(height: 12),
//
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Left: overall score
//                 Column(
//                   children: [
//                     const Text("4.0", style: TextStyle(fontSize: 48, fontWeight: FontWeight.w400, color: Colors.black)),
//                     _starRow(4.0, size: 20),
//                     const SizedBox(height: 4),
//                     const Text("1034 Ratings", style: TextStyle(fontSize: 12, color: Colors.grey)),
//                   ],
//                 ),
//                 const SizedBox(width: 16),
//                 // Right: breakdown bars
//                 Expanded(
//                   child: Column(
//                     children: _ratingBreakdown.map((r) {
//                       final total = _ratingBreakdown.fold<int>(0, (s, e) => s + (e['count'] as int));
//                       final fraction = (r['count'] as int) / total;
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 3),
//                         child: Row(
//                           children: [
//                             Icon(Icons.star, size: 12, color: Colors.amber),
//                             const SizedBox(width: 4),
//                             Text('${r['stars']}', style: const TextStyle(fontSize: 11)),
//                             const SizedBox(width: 6),
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(4),
//                                 child: LinearProgressIndicator(
//                                   value: fraction,
//                                   minHeight: 6,
//                                   backgroundColor: Colors.grey.shade200,
//                                   color: Colors.amber,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             SizedBox(
//                               width: 80,
//                               child: Text(r['label'] as String, style: const TextStyle(fontSize: 10, color: Colors.grey)),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//             // ── Real Photos / Videos ─────────────────────────────────────────
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text("Real photos(50+)", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
//                 Text("Real videos(10+)", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
//               ],
//             ),
//
//             const SizedBox(height: 10),
//
//             SizedBox(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: controller.images.length + 1,
//                 itemBuilder: (context, index) {
//                   // Last tile = "+47 more" overlay
//                   final isLast = index == controller.images.length;
//                   final imgUrl = isLast
//                       ? controller.images[0]
//                       : controller.images[index % controller.images.length];
//                   return Container(
//                     width: 90,
//                     margin: const EdgeInsets.only(right: 8),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(imgUrl, fit: BoxFit.cover),
//                         ),
//                         if (isLast)
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Container(
//                               color: Colors.black.withOpacity(0.5),
//                               alignment: Alignment.center,
//                               child: const Text("47+", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
//                             ),
//                           ),
//                         // Star badge
//                         Positioned(
//                           bottom: 4, left: 4,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.85),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: const Text("⭐ 4.5", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // ── Reviews ──────────────────────────────────────────────────────
//             ..._reviews.map((r) => Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _starRow(r['rating'] as double, size: 14),
//                   const SizedBox(height: 4),
//                   Text(r['comment'] as String, style: const TextStyle(fontSize: 13, color: Colors.black87)),
//                   const SizedBox(height: 4),
//                   Text("${r['name']} • ${r['time']}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
//                 ],
//               ),
//             )),
//
//             TextButton(
//               onPressed: () {},
//               child: const Text("View all", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
//             ),
//
//             const SizedBox(height: 8),
//
//             // ── Trust badges ─────────────────────────────────────────────────
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _trustBadge(Icons.verified_outlined, "Genuine Product"),
//                 _trustBadge(Icons.security_outlined, "Quality Checked"),
//               ],
//             ),
//
//             const SizedBox(height: 24),
//
//             // ── Similar Products ─────────────────────────────────────────────
//             const Text("Similar Products", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
//
//             const SizedBox(height: 12),
//
//             SizedBox(
//               height: 280,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _similarProducts.length,
//                 itemBuilder: (context, index) {
//                   final img = _similarProducts[index];
//                   return Container(
//                     width: 150,
//                     margin: const EdgeInsets.only(right: 12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.network(img, height: 160, width: 150, fit: BoxFit.cover),
//                             ),
//                             Positioned(
//                               top: 6, left: 6,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                 decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
//                                 child: const Text("10% OFF", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 6),
//                         Row(children: [
//                           const Icon(Icons.star, color: Colors.amber, size: 12),
//                           const Text(" 4.5", style: TextStyle(fontSize: 11)),
//                           const Spacer(),
//                           const Text("⊕ 1 | ⬤ 4 | ★ 4.5", style: TextStyle(fontSize: 9, color: Colors.grey)),
//                         ]),
//                         const Text("Polo", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
//                         const Text("BROWN T-SHIRT", style: TextStyle(fontSize: 11, color: Colors.grey)),
//                         const SizedBox(height: 4),
//                         Row(children: const [
//                           Text("Rs.1,100", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                           SizedBox(width: 6),
//                           Text("1500", style: TextStyle(fontSize: 11, color: Colors.grey, decoration: TextDecoration.lineThrough)),
//                         ]),
//                         const SizedBox(height: 6),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 30,
//                           child: OutlinedButton(
//                             onPressed: () {},
//                             style: OutlinedButton.styleFrom(
//                               padding: EdgeInsets.zero,
//                               side: const BorderSide(color: Colors.black),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                             ),
//                             child: const Text("Add to Cart", style: TextStyle(color: Colors.black, fontSize: 12)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // ── You may also like ────────────────────────────────────────────
//             const Text("You may also like", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
//
//             const SizedBox(height: 12),
//
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: _youMayAlsoLike.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.62,
//               ),
//               itemBuilder: (context, index) {
//                 final item = _youMayAlsoLike[index];
//                 return StatefulBuilder(
//                   builder: (context, setState) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 item['img'] as String,
//                                 height: 160,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                               top: 6, left: 6,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                 decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
//                                 child: Text(item['off'] as String, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 6, right: 6,
//                               child: GestureDetector(
//                                 onTap: () => setState(() => item['wishlisted'] = !(item['wishlisted'] as bool)),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(4),
//                                   decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                                   child: Icon(
//                                     (item['wishlisted'] as bool) ? Icons.favorite : Icons.favorite_border,
//                                     color: (item['wishlisted'] as bool) ? Colors.pinkAccent : Colors.grey,
//                                     size: 18,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 6),
//                         Row(children: [
//                           const Icon(Icons.star, color: Colors.amber, size: 12),
//                           const Text(" 4.5", style: TextStyle(fontSize: 11)),
//                         ]),
//                         Text(item['brand'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
//                         Text(item['type'] as String, style: const TextStyle(fontSize: 11, color: Colors.grey)),
//                         const SizedBox(height: 4),
//                         Row(children: [
//                           Text(item['price'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                           const SizedBox(width: 6),
//                           Text(item['mrp'] as String, style: const TextStyle(fontSize: 11, color: Colors.grey, decoration: TextDecoration.lineThrough)),
//                         ]),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ── Reusable widgets ─────────────────────────────────────────────────────────
//
//   Widget _trustBadge(IconData icon, String label) {
//     return Container(
//       width: 140,
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade200),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, size: 32, color: Colors.amber),
//           const SizedBox(height: 6),
//           Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
//         ],
//       ),
//     );
//   }
//
//   Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Icon(icon, size: 16),
//       ),
//     );
//   }
//
//   Widget _iconButton({required IconData icon, required VoidCallback onTap, Color color = Colors.black}) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)],
//         ),
//         child: Icon(icon, color: color),
//       ),
//     );
//   }
//
//   Widget topIcons({required String icon, required VoidCallback onIconTap}) {
//     return GestureDetector(
//       onTap: onIconTap,
//       child: SvgPicture.asset(icon, height: 20, width: 20),
//     );
//   }
// }

import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/controller/productDetailController.dart';
import 'package:deenitaindia/view/cart.dart';
import 'package:deenitaindia/view/wishlistScreen.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final ProductDetailController c = Get.put(ProductDetailController());

  // ── Local dummy data (reviews / ratings / products) ──────────────────────────


  // ── Helpers ──────────────────────────────────────────────────────────────────

  Widget _starRow(double rating, {double size = 16, Color color = Colors.amber}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) return Icon(Icons.star,        size: size, color: color);
        if (i < rating)         return Icon(Icons.star_half,   size: size, color: color);
        return                         Icon(Icons.star_border, size: size, color: color);
      }),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      // ════════════════════════════════ APP BAR ════════════════════════════════
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: const TextStyle(fontSize: 12, color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          _topIcon(icon: AppImage.fav,          onTap: () => Get.to(() => WishlistScreen())),
          const SizedBox(width: 8),
          _topIcon(icon: AppImage.shoppingBag,  onTap: () => Get.to(() => CartView())),
          const SizedBox(width: 8),
        ],
      ),

      // ════════════════════════════ FIXED BOTTOM BAR ════════════════════════════
      bottomNavigationBar: _buildBottomBar(),

      // ════════════════════════════════  BODY  ════════════════════════════════
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Brand banner ──────────────────────────────────────────────────
            _buildBrandBanner(),
            const SizedBox(height: 20),

            // ── Main image + overlays ─────────────────────────────────────────
            _buildMainImage(screenSize),
            const SizedBox(height: 12),

            // ── Thumbnails ────────────────────────────────────────────────────
            _buildThumbnails(),
            const SizedBox(height: 16),

            // ── Product title ─────────────────────────────────────────────────
            const Text(
              'Lionies Gija Cotton Slim Fit Self-Design Off Pink Party Shirt',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            const SizedBox(height: 8),

            // ── Delivery badge ────────────────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.electric_bolt, color: Colors.amber, size: 15),
                const SizedBox(width: 4),
                const Text('30mins Dilivev', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),

            // ── Size selector ─────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Select size', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black)),
                Text('Size Chart', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            _buildSizeSelector(),
            const SizedBox(height: 16),

            // ── Quantity ──────────────────────────────────────────────────────
            const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black)),
            const SizedBox(height: 10),
            _buildQtyRow(),
            const SizedBox(height: 24),

            // ══════════════════ SPECIFICATIONS SECTION ════════════════════════
            _buildSpecSection(),
            const SizedBox(height: 24),

            // ── Ratings ───────────────────────────────────────────────────────
            const Divider(),
            const SizedBox(height: 12),
            _buildRatings(),
            const SizedBox(height: 20),

            // ── Real Photos / Videos ──────────────────────────────────────────
            _buildPhotoVideoRow(),
            const SizedBox(height: 10),
            _buildPhotoStrip(),
            const SizedBox(height: 20),

            // ── Reviews ───────────────────────────────────────────────────────
            _buildReviews(),

            // ── Trust badges ──────────────────────────────────────────────────
            const SizedBox(height: 8),
            _buildTrustBadges(),
            const SizedBox(height: 24),

            // ── Similar Products ──────────────────────────────────────────────
            const Text('Similar Products', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            _buildSimilarProducts(onTapCard: () {  }, onAddToCartTap: () {  }, onLikeTap: () {  }, image: AppImage.shirt),
            const SizedBox(height: 24),

            // ── You may also like ─────────────────────────────────────────────
            const Text('You may also like', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            _buildYouMayAlsoLike(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════ BOTTOM BAR ══════════════════════════════════════

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Price column
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: const [
                      Text(
                        'Rs.1,100',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '1,500',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '10% OFF',
                    style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Buy button
            SizedBox(
              height: 48,
              width: 150,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppImage.shoppingBag,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  height: 18,
                ),
                label: const Text(
                  'Buy',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════ SPEC SECTION ════════════════════════════════════

  Widget _buildSpecSection() {
    return Obx(() {
      final tabIdx = c.specTabIndex.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Scrollable tab strip ──
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(c.specTabs.length, (i) {
                final selected = tabIdx == i;
                return GestureDetector(
                  onTap: () => c.setSpecTab(i),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? Colors.black : Colors.white,
                      border: Border.all(color: selected ? Colors.black : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      c.specTabs[i],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 16),

          // ── Tab content ──
          if (tabIdx == 0) _buildSpecificationsTab(),
          if (tabIdx == 1) _buildShowcaseTab(),
          if (tabIdx == 2) _buildDescriptionTab(),
          if (tabIdx == 3) _buildAllDetailsTab(),
        ],
      );
    });
  }

  // ── Tab 0: Specifications ─────────────────────────────────────────────────────
  Widget _buildSpecificationsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Key Features
        const Text('Key Features', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        const SizedBox(height: 8),
        ...c.keyFeatures.map((f) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(fontSize: 13, color: Colors.black54)),
              Expanded(child: Text(f, style: const TextStyle(fontSize: 13, color: Colors.black87))),
            ],
          ),
        )),

        const SizedBox(height: 16),

        // All Details table
        const Text('All Details', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        const SizedBox(height: 8),
        ...c.specifications.asMap().entries.map((entry) {
          final isEven = entry.key.isEven;
          final spec   = entry.value;
          return Container(
            color: isEven ? Colors.grey.shade50 : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  child: Text(spec['label']!, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ),
                Expanded(
                  child: Text(spec['value']!, style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ── Tab 1: Showcase ───────────────────────────────────────────────────────────
  Widget _buildShowcaseTab() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: c.images.length,
        itemBuilder: (_, i) => Container(
          width: 140,
          margin: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(c.images[i], fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  // ── Tab 2: Description ────────────────────────────────────────────────────────
  Widget _buildDescriptionTab() {
    return Text(c.description, style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.6));
  }

  // ── Tab 3: All Details (compact table) ───────────────────────────────────────
  Widget _buildAllDetailsTab() {
    return Column(
      children: c.specifications.asMap().entries.map((entry) {
        final isEven = entry.key.isEven;
        final spec   = entry.value;
        return Container(
          color: isEven ? Colors.grey.shade50 : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 130,
                child: Text(spec['label']!, style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ),
              Expanded(
                child: Text(spec['value']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ════════════════════════════ SECTION BUILDERS ════════════════════════════════

  Widget _buildBrandBanner() {
    return Container(
      decoration: const BoxDecoration(color: AppColors.yellow_shade),
      child: Row(
        children: [
          Image.network(
            'https://t3.ftcdn.net/jpg/03/34/79/68/360_F_334796865_VVTjg49nbLgQPG6rgKDjVqSb5XUhBVsW.jpg',
            height: 80, width: 80, fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rare Rabbit',      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                Text('Men Olive Regular', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
              ],
            ),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: const [
                      Text('Rs.1,100', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                      SizedBox(width: 6),
                      Text('1,500',    style: TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                  const Text('10% OFF', style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, size: 22, color: Colors.black54),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildMainImage(Size screenSize) {
    return Stack(
      children: [
        Obx(() => Image.network(
          c.images[c.selectedImageIndex.value],
          width: double.infinity,
          height: screenSize.height * 0.4,
          fit: BoxFit.cover,
        )),
        Positioned(
          top: 12, right: 12,
          child: Obx(() => _circleIconButton(
            icon:  c.isWishlisted.value ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            color: c.isWishlisted.value ? Colors.pinkAccent : Colors.black,
            onTap: c.toggleWishlist,
          )),
        ),
        Positioned(
          top: 70, right: 12,
          child: _circleIconButton(icon: CupertinoIcons.cart, onTap: () {}),
        ),
      ],
    );
  }

  Widget _buildThumbnails() {
    return SizedBox(
      height: 88,
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: c.images.length,
        itemBuilder: (_, index) {
          final selected = c.selectedImageIndex.value == index;
          return GestureDetector(
            onTap: () => c.changeImage(index),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: selected ? Colors.black : Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(c.images[index], width: 70, height: 70, fit: BoxFit.cover),
              ),
            ),
          );
        },
      )),
    );
  }

  Widget _buildSizeSelector() {
    return SizedBox(
      height: 40,
      child: ListView.builder(               // ← No Obx here
        scrollDirection: Axis.horizontal,
        itemCount: c.sizes.length,           // plain list, safe outside Obx
        itemBuilder: (_, index) {
          return Obx(() {                    // ← Obx only around what reads .obs
            final selected = c.selectedSizeIndex.value == index;
            return GestureDetector(
              onTap: () => c.changeSize(index),
              child: Container(
                alignment: Alignment.center,
                width: 48,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: selected ? AppColors.yellow_shade : Colors.white,
                  border: Border.all(
                    color: selected ? Colors.black : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  c.sizes[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildQtyRow() {
    return Obx(() => Row(
      children: [
        _qtyButton(icon: CupertinoIcons.minus, onTap: c.decreaseQty),
        const SizedBox(width: 16),
        Text(c.count.value.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(width: 16),
        _qtyButton(icon: Icons.add, onTap: c.increaseQty),
      ],
    ));
  }

  Widget _buildRatings() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const Text('4.0', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700)),
            _starRow(4.0, size: 20),
            const SizedBox(height: 4),
            const Text('1034 Ratings', style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: c.ratingBreakdown.map((r) {
              final total    = c.ratingBreakdown.fold<int>(0, (s, e) => s + (e['count'] as int));
              final fraction = (r['count'] as int) / total;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text('${r['stars']}', style: const TextStyle(fontSize: 11)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: fraction,
                          minHeight: 6,
                          backgroundColor: Colors.grey.shade200,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 82,
                      child: Text(r['label'] as String, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoVideoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Real photos(50+)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        Text('Real videos(10+)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }

  Widget _buildPhotoStrip() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: c.images.length + 1,
        itemBuilder: (_, index) {
          final isLast = index == c.images.length;
          final imgUrl = isLast ? c.images[0] : c.images[index % c.images.length];
          return Container(
            width: 88,
            margin: const EdgeInsets.only(right: 8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imgUrl, fit: BoxFit.cover),
                ),
                if (isLast)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      color: Colors.black54,
                      alignment: Alignment.center,
                      child: const Text('47+', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                  ),
                Positioned(
                  bottom: 4, left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('⭐ 4.5', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviews() {
    return Column(
      children: [
        ...c.reviews.map((r) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _starRow(r['rating'] as double, size: 14),
              const SizedBox(height: 4),
              Text(r['comment'] as String, style: const TextStyle(fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 4),
              Text('${r['name']} • ${r['time']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        )),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: const Text('View all', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }

  Widget _buildTrustBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _trustBadge(Icons.verified_outlined, 'Genuine Product'),
        _trustBadge(Icons.security_outlined,  'Quality Checked'),
      ],
    );
  }

  Widget _buildSimilarProducts(
  {required VoidCallback onTapCard,
    required VoidCallback onAddToCartTap,
    required VoidCallback onLikeTap,
    required String image,}
      ) {
    return SizedBox(
      height: 275,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: c.similarProducts.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: onTapCard,
            child: Container(
              margin: EdgeInsets.only(
                left: 12
              ),
              width: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      children: [
                        Image.asset(AppImage.shirt,
                            height: 150, width: double.infinity, fit: BoxFit.cover),
                        Positioned(
                            bottom: 8,
                            left: 8,
                            child: _colorRatingPill(small: true)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Polo',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                        const Text('BROWN T-SHIRT',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                letterSpacing: 0.3)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text('1,500',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black38,
                                    decoration: TextDecoration.lineThrough)),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('15% OFF',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orange)),
                            ),
                            const SizedBox(width: 4),
                            const Text('Rs.1,100',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: AppButton(
                        title: "Add To Cart",
                        onTap: onAddToCartTap,
                        bgColor: AppColors.yellow_shade,
                        textColor: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _colorRatingPill({bool small = false}) {
    final size = small ? 10.0 : 12.0;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: small ? 6 : 8, vertical: small ? 3 : 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06), blurRadius: 6)
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...[Colors.red, Colors.blueGrey, Colors.blue].map((c) => Container(
            margin: const EdgeInsets.only(right: 4),
            height: size,
            width: size,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          )),
          Text("+3",
              style: TextStyle(
                  fontSize: small ? 10 : 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text("|",
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: small ? 11 : 13)),
          ),
          Icon(Icons.star_rounded,
              color: Colors.amber, size: small ? 12 : 14),
          const SizedBox(width: 2),
          Text("4.5",
              style: TextStyle(
                  fontSize: small ? 10 : 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildYouMayAlsoLike() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: c.youMayAlsoLike.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (_, index) {
        final item = c.youMayAlsoLike[index];

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔥 IMAGE SECTION
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    Image.asset(
                      AppImage.shirt,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    /// 🔴 DISCOUNT BADGE
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item['off'] ?? "10% OFF",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    /// ⭐ COLOR + RATING
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: _colorRatingPill(small: true),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              /// 🏷 BRAND
              Text(
                item['brand'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 2),

              /// 🧾 TYPE
              Text(
                item['type'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 6),

              /// 💰 PRICE ROW + ❤️ WISHLIST
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          item['price'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item['mrp'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ❤️ FLOATING HEART BUTTON
                  Obx(() => GestureDetector(
                    onTap: () => c.isWishlisted.toggle(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        c.isWishlisted.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: c.isWishlisted.value
                            ? Colors.red
                            : Colors.grey,
                        size: 18,
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ════════════════════════════ SMALL REUSABLE WIDGETS ═════════════════════════



  Widget _offBadge(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
  );

  Widget _trustBadge(IconData icon, String label) => Container(
    width: 140,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Icon(icon, size: 30, color: Colors.amber),
        const SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
      ],
    ),
  );

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 16),
    ),
  );

  Widget _circleIconButton({required IconData icon, required VoidCallback onTap, Color color = Colors.black}) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)],
      ),
      child: Icon(icon, color: color),
    ),
  );

  Widget _topIcon({required String icon, required VoidCallback onTap}) => GestureDetector(
    onTap: onTap,
    child: SvgPicture.asset(icon, height: 20, width: 20),
  );
}