import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/utils/theme/colors.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class BotPage extends StatefulWidget {
  const BotPage({Key? key}) : super(key: key);

  @override
  State<BotPage> createState() => _BotPageState();
}

class _BotPageState extends State<BotPage> {
  final _openAI = OpenAI.instance.build(
    token: "",
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );

  final ChatUser _currentUser = ChatUser(
    id: "1",
    firstName: "Yann-Armel",
    lastName: "GALLIE",
  );

  final ChatUser _gptChatUser = ChatUser(
    id: "2",
    firstName: "Chat",
    lastName: "GPT",
  );

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUser = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.secondary,
        body: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Chat Bot AI",
                    style: GoogleFonts.poppins(
                      color: TColors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DashChat(
                  currentUser: _currentUser,
                  typingUsers: _typingUser,
                  messageOptions: const MessageOptions(
                    currentUserContainerColor: TColors.orange,
                    containerColor: TColors.error,
                    textColor: TColors.textWhite,
                  ),
                  onSend: (ChatMessage m) {
                    getChatResponse(m);
                  },
                  messages: _messages,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUser.add(_gptChatUser);
    });
    final _messagesHistory =
        _messages.reversed.map((m) {
          if (m.user == _currentUser) {
            return {'role': 'user', 'content': m.text};
          } else {
            return {'role': 'assistant', 'content': m.text};
          }
        }).toList();

    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: _messagesHistory,
      maxToken: 200,
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _gptChatUser,
              createdAt: DateTime.now(),
              text: element.message!.content,
            ),
          );
        });
      }
    }
    setState(() {
      _typingUser.remove(_gptChatUser);
    });
  }
}
