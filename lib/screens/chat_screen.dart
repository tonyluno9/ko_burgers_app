import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/bottom_nav.dart';
import '../models/bot_message.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    messages.add({
      "text":
          "Soy KAY/O 🤖🔥\nPregúntame por promos, recomendaciones o niveles.",
      "isUser": false
    });
  }

  @override
  Widget build(BuildContext context) {
    final botData = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("KAY/O Assistant")),
      bottomNavigationBar: const BottomNav(index: 2),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: messages
                  .map((m) =>
                      ChatBubble(message: m["text"], isUser: m["isUser"]))
                  .toList(),
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          hintText: "Escribe tu mensaje..."),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isEmpty) return;

                    setState(() {
                      messages.add({"text": text, "isUser": true});
                    });
                    controller.clear();

                    if (botData.hasValue) {
                      final reply =
                          _matchReply(text.toLowerCase(), botData.value!);
                      setState(() {
                        messages.add({"text": reply, "isUser": false});
                      });
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _matchReply(String input, List<BotMessage> list) {
    for (final b in list) {
      if (input.contains(b.question.toLowerCase())) {
        return b.answer;
      }
    }

    if (input.contains("hamburguesa") ||
        input.contains("burger") ||
        input.contains("recom")) {
      return "Si quieres algo ligero, ve por LVL 1. Si quieres KO, LVL 3 🔥.";
    }

    return "No entendí bien, pero puedo ayudarte con promos, recomendaciones o niveles.";
  }
}
