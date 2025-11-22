import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bot_message.dart';
import '../services/chat_service.dart';

final chatProvider = FutureProvider<List<BotMessage>>((ref) {
  return ChatService.loadBotMessages();
});
