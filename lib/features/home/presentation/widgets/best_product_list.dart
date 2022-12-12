// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';



// class NearbyStoreList extends StatelessWidget {
//   const NearbyStoreList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         RestaurantCategoryTitle(
//           onTap: () => Navigator.of(context).pushNamed(
//             Routing.VIEW_ALL_STORE,
//             arguments: ViewAllStorePageRouteArguments(
//                 provider: context.read<NearbyStoreProvider>(),
//                 storeType: StoreType.nearby),
//           ),
//           title: appLoc.shopsNearYou,
//           subtitle: appLoc.iPickedUpAPopularStoreNearYou,
//         ),
//         StreamBuilder<StoreState>(
//           stream: context.read<NearbyStoreProvider>().fetchNearbyStore(
//               locator<Session>().currentLat, locator<Session>().currentLong),
//           builder: (_, snap) {
//             if (snap.hasData) {
//               if (snap.data is StoreLoaded) {
//                 final _stores = (snap.data as StoreLoaded).data;
//                 return SizedBox(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: SIZE_SMALL),
//                     physics: const NeverScrollableScrollPhysics(),
//                     scrollDirection: Axis.vertical,
//                     itemCount: _stores.length <= 3 ? _stores.length : 3,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return CardWidget(
//                         isFullWidth: true,
//                         store: _stores[index],
//                       );
//                     },
//                   ),
//                 );
//               } else if (snap.data is StoreFailure) {
//                 final failure = (snap.data as StoreFailure).failure;
//                 Fluttertoast.showToast(msg: getErrorMessage(failure));
//                 return Text(
//                   getErrorMessage(failure),
//                   style: restaurantCategoryHomeSubtitleTextStyle,
//                 );
//               } else {
//                 return Shimmer.fromColors(
//                     baseColor: Colors.grey[300]!,
//                     highlightColor: Colors.grey[100]!,
//                     child: const SizedBox(
//                         child: ShimmerCardWidget(
//                       isFullWidth: true,
//                     )));
//               }
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ],
//     );
//   }
// }
