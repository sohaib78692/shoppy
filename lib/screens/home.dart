import 'package:flutter/material.dart';
import 'package:shoppy/components/grid_card.dart';
import 'package:shoppy/models/product.dart';
import 'package:shoppy/screens/product.dart';
import '../components/loader.dart';
import '../utils/firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final data = ["1", "2"];
  Future<List<Product>>? products;

  @override
  void initState() {
    super.initState();
    setState(() {
      products = FirestoreUtil.getProducts([]);
    });
  }

  onCardPress(Product product) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductScreen(
                  product: product,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: products,
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data?.length,
              padding: const EdgeInsets.symmetric(vertical: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 30, crossAxisSpacing: 30),
              itemBuilder: (BuildContext context, int index) {
                return GridCard(
                    product: snapshot.data![index],
                    index: index,
                    onpress: () {
                      onCardPress(snapshot.data![index]);
                    });
              },
            );
          } else {
            return const Center(child: Loader());
          }
        });

    // Container(
    //   child: GridView.builder(
    //     itemCount:data.length ,
    //     padding: const EdgeInsets.symmetric(vertical: 30),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 30,
    //       crossAxisSpacing: 30,
    //     ),
    //     itemBuilder: (BuildContext context, int index){
    //       return GridCard(index: index,
    //        onpress: onCardPress);
    //     },
    //   )
    // );
  }
}
