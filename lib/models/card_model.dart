import 'package:flutter/material.dart';

enum Suit {
  Hearts,
  Clubs,
  Diamonds,
  Spades,
  Other
}

class CardModel {
  final String image;
  final Suit suit;
  final String value;

  CardModel({
    required this.image,
    required this.suit,
    required this.value
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(image: json['image'], suit: stringToSuit(json['suit']), value: json['value']);
  }

  static Suit stringToSuit(String suit) {
    switch (suit.toUpperCase().trim()) {
      case "HEARTS":
        return Suit.Hearts;
      case "CLUBS":
        return Suit.Clubs;
      case "DIAMONDS":
        return Suit.Diamonds;
      case "SPADES":
        return Suit.Spades;
      default:
        return Suit.Other;
    }
  }
}