import 'package:ecom_graphql/main.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GraphQl"),
      ),
      // body: Text('aaa'),
      body: Query(
        options: QueryOptions(
          document: gql(productsGraphQL),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text('Exception: ${result.hasException.toString()}');
          }
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List productList = result.data?['collections']['edges']['node'];
          print(productList);
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(19.0),
                child: Text(
                  "Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: productList.length,
                  itemBuilder: (_, index) {
                    var products = productList[index];
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.0),
                          height: 180,
                          width: 180,
                          // child: Text(products['image'].toString()),
                          // child: Image.network(products['image']),
                        ),
                        Text(
                          products['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Text(products['moneyFormat'])
                      ],
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}


// import 'package:ecom_graphql/main.dart';
// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("GraphQl"),
//       ),
//       body: Query(
//         options: QueryOptions(
//           document: gql(productsGraphQL),
//         ),
//         builder: (QueryResult result, {fetchMore, refetch}) {
//           if (result.hasException) {
//             return Text(result.hasException.toString());
//           }
//           if (result.isLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final productList = result.data?['shop'];
//           print(productList);
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(19.0),
//                 child: Text(
//                   "Products",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 2.0,
//                     crossAxisSpacing: 2.0,
//                     childAspectRatio: 0.75,
//                   ),
//                   itemCount: productList.length,
//                   itemBuilder: (_, index) {
//                     var products = productList[index]['shop'];
//                     return Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(2.0),
//                           height: 180,
//                           width: 180,
//                           // child: Text(products['image'].toString()),
//                           // child: Image.network(products['onlineStoreUrl']),
//                         ),
//                         Text(
//                           products['name'],
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         // Text(products['title']),
//                       ],
//                     );
//                   },
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
