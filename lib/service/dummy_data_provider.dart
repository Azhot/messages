import 'package:messages/model/author.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/model/message.dart';

class DummyDataProvider {
  static final List<Author> _authors = [
    Author("Azhot"),
    Author('Hebus'),
  ];

  static final List<Message> _messages = [
    Message(_authors[0], "First message test."),
    Message(_authors[1], "Second message test."),
    Message(_authors[1],
        "Third message test. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt purus sem, ac rutrum urna aliquet ut. Nam tincidunt ut odio vel lacinia. Vivamus sed metus vel velit porta blandit. Integer convallis tempor mi scelerisque hendrerit. Cras commodo ante dui, at volutpat nulla dapibus sit amet. Vestibulum at urna vel lacus hendrerit eleifend fermentum sit amet arcu. Suspendisse convallis ut lectus ac lobortis. Fusce eleifend facilisis risus et pulvinar. Donec nec ante sapien. Vestibulum nec purus porta, fringilla est ut, gravida lacus."),
    Message(_authors[0], "Fourth message test."),
    Message(_authors[1], "Fifth message test."),
    Message(_authors[0],
        "Sixth message test. Vivamus placerat ac nisi sit amet auctor. Praesent tempus, felis a auctor venenatis, nibh diam convallis mi, vitae ullamcorper augue neque nec erat. Donec placerat diam ac tellus mollis mattis. Proin convallis mi vitae elit scelerisque, a dapibus lacus ornare. Mauris non elementum augue. Etiam volutpat volutpat orci in lacinia. Suspendisse egestas augue ut felis tincidunt accumsan. Duis tristique venenatis egestas."),
  ];

  static List<Conversation> provideDummyConversation() {
    return [
      Conversation(
          _authors[0].name, _messages.getRange(0, 3).map((e) => e).toList()),
      Conversation(
          _authors[1].name, _messages.getRange(3, 6).map((e) => e).toList()),
    ];
  }
}
