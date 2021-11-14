


import 'package:intl/intl.dart';

class MessageModel {
  final messageId;
  final content;
  final userId;
  final senderId;
  final friendId;
  final friendName;
  final friendImage; 
  final timestamp;
  final type;


  MessageModel(
      this.messageId,
      this.content,
      this.userId,
      this.senderId,
      this.friendId,
      this.friendName,
      this.friendImage,
      this.timestamp,
      this.type);

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'content': content,
      'userId': userId,
      'senderId': senderId,
      'friendId': friendId,
      'friendName': friendName,
      'friendImage': friendImage,
      'timestamp': timestamp,
      'date': date,
      'type':type,

 };
  }

  static MessageModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MessageModel(
      map['messageId'],
      map['content'],
      map['userId'],
      map['senderId'],
      map['friendId'],
      map['friendName'],
      map['friendImage'],
      map['timestamp'],
      map['type'],);
  }

  String get date{
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd/MM/yyyy, HH:mm').format(dt);
  }

 
  }

//enum MessageType{Text, Image, Sticker}
