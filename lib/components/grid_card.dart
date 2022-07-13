import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shoppy/utils/custom_theme.dart';

import '../models/product.dart';

class GridCard extends StatelessWidget {
  final int index;
  final void Function() onpress;
  final Product product;
  const GridCard({Key? key, required this.index, required this.onpress, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index%2==0? const EdgeInsets.only(left: 22) : const EdgeInsets.only(right: 22),
      decoration: CustomTheme.getCardDecoration(),
      child: GestureDetector(
        onTap: onpress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: [
              Expanded(child: SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl:"https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHx8&w=1000&q=80",
                  fit: BoxFit.cover,
                   ) ,
                  )),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(product.title, style: Theme.of(context).textTheme.headlineSmall,),
                          ),
                          Text(
                            product.price.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                          
                        ],
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
