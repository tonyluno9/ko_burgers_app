import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/bot_message.dart';

class ChatService {
  static Future<List<BotMessage>> loadBotMessages() async {
    final data = await rootBundle.loadString('assets/data/bot.json');
    final jsonList = json.decode(data) as List;
    return jsonList.map((e) => BotMessage.fromJson(e)).toList();
  }
}
