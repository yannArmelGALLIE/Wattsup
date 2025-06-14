import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wattsup/constants/api.dart';
import 'package:wattsup/utils/theme/colors.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class BotPage extends StatefulWidget {
  const BotPage({Key? key}) : super(key: key);

  @override
  State<BotPage> createState() => _BotPageState();
}

class _BotPageState extends State<BotPage> {
  final ChatUser _currentUser = ChatUser(
    id: "1",
    firstName: "Yann-Armel",
    lastName: "GALLIE",
  );

  final ChatUser _gptChatUser = ChatUser(
    id: "2",
    firstName: "WattsUp",
    lastName: "Bot",
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
                    "WattsUp Bot AI",
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

    // Remplace ici par l’URL de ton API
    final apiUrl = '$api/api/chat/';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "utilisateur_id": "1", 
          "message": m.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botMessage = data["bot_response"] ?? "Erreur de réponse";

        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _gptChatUser,
              createdAt: DateTime.now(),
              text: botMessage,
            ),
          );
        });
      } else {
        print("Erreur API : ${response.body}");
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _gptChatUser,
              createdAt: DateTime.now(),
              text: "Erreur lors de la communication avec le serveur.",
            ),
          );
        });
      }
    } catch (e) {
      print("Exception: $e");
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _gptChatUser,
            createdAt: DateTime.now(),
            text: "Erreur réseau ou serveur injoignable.",
          ),
        );
      });
    }

    setState(() {
      _typingUser.remove(_gptChatUser);
    });
  }
}
