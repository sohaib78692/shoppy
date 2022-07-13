import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shoppy/main.dart';
import 'package:shoppy/utils/custom_theme.dart';

class ListCard extends StatelessWidget {
  const ListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 123,
      margin: const EdgeInsets.only(left: 30,right: 30,bottom: 30),
      decoration: CustomTheme.getCardDecoration() ,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl:"https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHx8&w=1000&q=80" ,
                    fit: BoxFit.cover,
                  ),
                ) ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.only(bottom: 8),
                          child: Text("Title", style: Theme.of(context).textTheme.headlineSmall,),
                          ),
                          Padding(padding: const EdgeInsets.only(bottom: 8),
                          child: Text("Qty:1", style: Theme.of(context).textTheme.headlineSmall,),
                          ),
                          Padding(padding: const EdgeInsets.only(bottom: 8),
                          child: Text("\$ price", style: Theme.of(context).textTheme.headlineSmall,),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );

  }
}