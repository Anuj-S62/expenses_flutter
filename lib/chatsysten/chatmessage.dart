import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
        required this.text,
        required this.sender,
        this.isImage = false});

  final String text;
  final String sender;
  final bool isImage;




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0,4,18,4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: sender=="bot" ? Colors.yellow[200] : Colors.blueGrey,
                  borderRadius: BorderRadius.circular(30)
                ),
                  child: Text(sender[0].capitalized,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black54),)
              ),
            ],
          ),
          Expanded(
            child: isImage
                ? AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                text,
                loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : const CircularProgressIndicator.adaptive(),
              ),
            )
                : Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                  child: SelectableText(text,style: TextStyle(color: Colors.grey[200],fontSize: 16),),
                ),
          ),
        ],
      ),
    );
  }
}
