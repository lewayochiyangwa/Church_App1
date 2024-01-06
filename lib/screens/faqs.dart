import 'package:flutter/material.dart';


class FaqPage extends StatelessWidget {
  final List<FaqItem> faqItems = [
    FaqItem(
      question: 'What is Premium?',
      answer:
      'Premium is a subscription plan that gives you access to exclusive content and features.',
    ),
    FaqItem(
      question: 'How do I subscribe to Premium?',
      answer:
      'You can subscribe to Premium by visiting our website or in the app under the Premium tab.',
    ),
    FaqItem(
      question: 'How do I cancel my Premium subscription?',
      answer:
      'You can cancel your Premium subscription by going to your account settings and selecting the cancel option.',
    ),
    FaqItem(
      question: 'What devices are supported?',
      answer:
      'Our app is available on iOS and Android devices, as well as web browsers on desktop and laptop computers.',
    ),
    FaqItem(
      question: 'How do I report a problem?',
      answer:
      'If you encounter a problem with our app, please contact our support team through the app or our website.',
    ),

    FaqItem(
      question: 'How do I report a problem?kkkkkk',
      answer:
      'If you encounter a problem with our app, please contact our support team through the app or our website.',

    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Privacy'),
                SizedBox(width: 15,),
                Icon(Icons.help_outline),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(faqItems[index].question),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        faqItems[index].answer,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;


  FaqItem({
    required this.question,
    required this.answer,
  });
}

class FaqAudios {

  final Widget? button;

  FaqAudios({
    this.button
  });
}