import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:flutter/material.dart';
class AppMethod{

  static Future<void> imagePickerDialogue ({
    required BuildContext context,
    required Function getGalleryImage,
    required Function getCameraImage,
    required Function removeFunction,

  }) async{
    await showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(
            title: const Center(
              child: TextWidget(text: "Choose option"),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: (){
                      getGalleryImage();
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    label: const TextWidget(text: "Gallery",color: Colors.black,),
                    icon: const  Icon(Icons.image_aspect_ratio,color: Colors.black,),
                  ),
                  TextButton.icon(
                    onPressed: (){
                      getCameraImage();
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    label: const TextWidget(text: "Camera",color: Colors.black,),
                    icon: const  Icon(Icons.camera_alt_outlined,color: Colors.black,),
                  ),
                  TextButton.icon(
                    onPressed: (){
                      getCameraImage();
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    label: const TextWidget(text: "Remove",color: Colors.black,),
                    icon: const  Icon(Icons.remove,color: Colors.black,),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}