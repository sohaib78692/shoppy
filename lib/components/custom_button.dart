import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shoppy/components/loader.dart';
import 'package:shoppy/utils/custom_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onpress;
  final bool loading;
  const CustomButton({Key? key, required this.text, required this.onpress,  this.loading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: CustomTheme.yellow,
        boxShadow: CustomTheme.buttonShadow,
      ),
      child: MaterialButton(
        onPressed: loading? null: onpress,
        child: loading? 
        const Loader(): 
        Text(text,
        style: Theme.of(context).textTheme.titleSmall,
        ) ,
         ),
    );
  }
}