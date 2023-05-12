import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';


class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.content,
    required this.isUserMessage,
    super.key,
  });

  final String content; // вміст повідомлення
  final bool isUserMessage; // чи є це повідомлення від користувача

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUserMessage // колір фону залежно від того, хто відправив повідомлення
            ? themeData.colorScheme.primary.withOpacity(0.8)
            : themeData.colorScheme.secondary.withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  isUserMessage ? 'You' : 'Personal Jesus', // показує хто відправив повідомлення
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            MarkdownWidget(
              data: content, // вміст повідомлення
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}