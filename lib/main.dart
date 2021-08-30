import 'package:ecom_graphql/home.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';

const productsGraphQL = """
{
  collections(first:5){
    edges{
      node{
        id
        title
      }
    }
  }
}
""";

void main() async {
  // await initHiveForFlutter();
  final HttpLink httpLink =
      HttpLink("https://ewiglife-ecomapp.myshopify.com/api/graphql");

  // ignore: unused_local_variable
  final AuthLink authLink = AuthLink(
      headerKey: 'X-Shopify-Storefront-Access-Token',
      getToken: () async => '86338fd3004e0c485ca61f68dd2c59e7');
  // ignore: unused_local_variable
  final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink, cache: GraphQLCache(store: InMemoryStore())));

  var app = GraphQLProvider(
    client: client,
    child: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}
