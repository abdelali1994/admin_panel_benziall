import 'package:admin_panel_benziall/constants/theme.dart';
import 'package:admin_panel_benziall/helpers/firebase_options/firebase_options.dart';
import 'package:admin_panel_benziall/provider/app_provider.dart';
import 'package:admin_panel_benziall/screens/home_page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
        // ..getUserListFun()
        // ..getCategoriesListFun(),
      child: MaterialApp(
        title: 'Admin Panel',
        theme: themeData,
        debugShowCheckedModeBanner: false, //remove debug banner
        home: const Homepage(),
      ),
    );
  }
}


///////////////// ListView///////////////////////////
// import 'package:flutter/material.dart';

// class Product {
//   final String name;
//   final String image;
//   final double price;
//   final int quantity;

//   Product(
//       {required this.name,
//       required this.image,
//       required this.price,
//       required this.quantity});
// }

// class ProductListView extends StatelessWidget {
//   final List<Product> products = [
//     Product(
//         name: 'منتج 1',
//         image: 'assets/images/product1.png',
//         price: 10.0,
//         quantity: 5),
//     Product(
//         name: 'منتج 2',
//         image: 'assets/images/product2.jpg',
//         price: 20.0,
//         quantity: 10),
//     Product(
//         name: 'منتج 3',
//         image: 'assets/images/product3.png',
//         price: 15.0,
//         quantity: 3),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('قائمة المنتجات'),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             margin: const EdgeInsets.only(bottom: 8.0),
//             child: Card(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       Image.asset(
//                         products[index].image,
//                         fit: BoxFit.contain,
//                         width: 100,
//                         height: 100,
//                       ),
//                       const Text(
//                         '155,5 درهم',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const Text(
//                         'الكولية',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(products[index].name),
//                           // Text('السعر: ${products[index].price} دولار'),
//                           const SizedBox(height: 8.0),
//                           Text(
//                             'عدد الباكيات في الكولية: ${products[index].quantity}',
//                           ),
//                           const SizedBox(height: 8.0),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text('السعر: ${products[index].price} دولار'),
//                         ElevatedButton(
//                           onPressed: () {
//                             // يتم تنفيذ الإجراء عند الضغط على الزر "أضف إلى السلة"
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green, // لون الزر الأخضر
//                     shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                           ),
//                           child: const Text('أضف إلى السلة'),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: ProductListView(),
//   ));
// }


///////////////////location/////////////
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//    runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Location Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String latitude = '';
//   String longitude = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Latitude: $latitude'),
//             Text('Longitude: $longitude'),
//             ElevatedButton(
//               child:const  Text('Get Location'),
//               onPressed: () {
//                 getLocation();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void getLocation() async {
//     // Request permission to access the location
//     PermissionStatus permission = await Permission.location.request();

//     if (permission.isDenied) {
//       // Handle permission denied
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Location Access'),
//             content: Text('Please enable location access from settings.'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   openAppSettings();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }

//     if (permission.isPermanentlyDenied) {
//       // Handle permission permanently denied
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return  AlertDialog(
//             title: Text('Location Access'),
//             content: Text('Location access is permanently denied.'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   openAppSettings();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }

//     // Get the current position
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {
//       latitude = '${position.latitude}';
//       longitude = '${position.longitude}';
//     });
//   }
// }
