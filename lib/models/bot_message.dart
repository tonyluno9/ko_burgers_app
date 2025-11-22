class BotMessage {
  final String question;
  final String answer;

  BotMessage({required this.question, required this.answer});

  factory BotMessage.fromJson(Map<String, dynamic> json) => BotMessage(
        question: json["question"],
        answer: json["answer"],
      );
}
