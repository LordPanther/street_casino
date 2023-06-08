import 'package:flutter/material.dart';

enum Suit {
  // ignore: constant_identifier_names
  Hearts,
  // ignore: constant_identifier_names
  Clubs,
  // ignore: constant_identifier_names
  Diamonds,
  // ignore: constant_identifier_names
  Spades,
  // ignore: constant_identifier_names
  Other
}

class CardModel {
  final String image;
  final Suit suit;
  final String value;

  CardModel({required this.image, required this.suit, required this.value});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        image: json['image'],
        suit: stringToSuit(json['suit']),
        value: json['value']);
  }

  static String stringToValue(String value) {
    switch (value.toUpperCase().trim()) {
      case "Ace":
        return "1";
      case "2":
        return "2";
      case "3":
        return "3";
      case "4":
        return "4";
      case "5":
        return "5";
      case "6":
        return "6";
      case "7":
        return "7";
      case "8":
        return "8";
      case "9":
        return "9";
      case "10":
        return "0";
      default:
        return "0";
    }
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

  static String suitToString(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
        return "Hearts";
      case Suit.Clubs:
        return "Clubs";
      case Suit.Diamonds:
        return "Diamonds";
      case Suit.Spades:
        return "Spades";
      case Suit.Other:
        return "Other";
    }
  }

  static String suitToUnicode(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
        return "\u2665";
      case Suit.Clubs:
        return "\u2663";
      case Suit.Diamonds:
        return "\u2666";
      case Suit.Spades:
        return "\u2660";
      case Suit.Other:
        return "Other";
    }
  }

  static Color suitToColor(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
      case Suit.Diamonds:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
