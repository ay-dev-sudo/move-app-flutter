import 'package:flutter/material.dart';
import 'package:move/utils/app_fonts.dart';

import '../utils/app_color.dart';

class AlertDialogUtils{
  static void  showLoading({required BuildContext context,required String msg}){
    showDialog(barrierDismissible: false,context: context, builder: (context) => AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(color: AppColor.silver,),
          SizedBox(width:20,),
          Text(msg ,style: AppFonts.inter16black,)
        ],
      ),
    )
    );
  }
  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);
  }

  static void showMessage({required BuildContext context,
    required String msg,
    String? title,
    String? pos,
    Function? posAction,
    String? nav,
    Function? navAction,


  }){
    List<Widget> actions =[];
    if (pos!=null) {
      actions.add(TextButton(onPressed: (){
        //Navigator.pop(context);
        posAction?.call();
      }, child: Text(pos,style: AppFonts.regular20black,)));
    }
    if (nav!=null) {
      actions.add(TextButton(onPressed: (){
        //Navigator.pop(context);
        navAction?.call();
      }, child: Text(nav,style: AppFonts.regular20black,)));
    }
    showDialog(context: context, builder: (context) {
      return AlertDialog(
          content: Text(msg,style:AppFonts.regular20black,),
          title:Text(title ?? "" ,style: AppFonts.regular20black,) ,
          actions: actions
      );
    },);
  }
}