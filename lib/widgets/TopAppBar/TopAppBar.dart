import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  String? title;
  TopAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions:[
        IconButton(
          icon: const Icon(Icons.phone),
          onPressed: (){
            showDialog(context: context, builder: (context) => Container(
              height: 300,
              child: AlertDialog(
                title:  const Text('Contact us on:', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500
                ),),
                content:  Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SelectableText('+977-9842979012'),
                        SelectableText('ishabhandari069@gmail.com')
                      ],
                    )
                ),
              ),
            ) );
          },
        )
      ],
      title: Text('$title ', style:const TextStyle(
          fontSize:20,
          fontWeight: FontWeight.w500
      ),
      ),
    );
  }
}
