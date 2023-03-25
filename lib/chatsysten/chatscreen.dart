import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chatmessage.dart';
// import 'threedots.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late OpenAI? chatGPT;
  bool _isImageSearch = false;

  bool _isTyping = false;

  @override
  void initState() {

    chatGPT = OpenAI.instance.build(
        token: "ChatGpt_Api_key",
        // Link for api - https://beta.openai.com/account/api-keys
        baseOption: HttpSetup(receiveTimeout: 60000)
    );
    // super.initState();
  }

  @override
  void dispose() {
    chatGPT?.close();
    chatGPT?.genImgClose();
    super.dispose();
  }



  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "user",
      isImage: false,
    );

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    if (_isImageSearch) {
      final request = GenerateImage(message.text, 1, size: "256x256");

      final response = await chatGPT!.generateImage(request);
      Vx.log(response!.data!.last!.url!);
      insertNewData(response.data!.last!.url!, isImage: true);
    } else {
      try{
      final request =
      CompleteText(prompt: message.text, model: kTranslateModelV3,maxTokens: 4000);

      final response = await chatGPT!.onCompleteText(request: request);
      Vx.log(response!.choices[0].text);
      insertNewData(response.choices[0].text, isImage: false);
      }catch(e){
        _isTyping = false;
        Text("Sorry can't find",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,letterSpacing: 0,color: Colors.white70),);
      }
    }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "bot",
      isImage: isImage,
    );

    setState(() {
      _isTyping = false;
      _messages.insert(0, botMessage);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      color: Colors.grey[900],
      child: Row(
        children: [
          Expanded(
            child: TextField(

              controller: _controller,
              onSubmitted: (value) => _sendMessage(),
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  hintText: "Ask me anything",
                  hintStyle: TextStyle(color: Colors.white70),

              ),
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ButtonBar(
            children: [
              IconButton(
                icon: const Icon(Icons.send,color: Colors.white70,),
                onPressed: () {
                  _isImageSearch = false;
                  _sendMessage();
                },
              ),
              TextButton(
                  onPressed: () {
                    _isImageSearch = true;
                    _sendMessage();
                  },
                  child: const Text("is Image?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,letterSpacing: 0,color: Colors.white70),))
            ],
          ),
        ],
      ).px16(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text("Chat with AI",style: TextStyle(color: Colors.grey,letterSpacing: 1),),
          backgroundColor: Colors.grey[900],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    },
                  )),
              if (_isTyping) Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text("On it...",style: TextStyle(fontSize: 25,color: Colors.grey,letterSpacing: 1),),
              ),
              const Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                ),
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }
}
