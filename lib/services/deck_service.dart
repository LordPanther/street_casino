import 'package:street_casino/models/deck_model.dart';
import 'package:street_casino/models/draw_model.dart';
import 'package:street_casino/services/api_service.dart';

class DeckService extends ApiService {
  String cards =
      'AS,AD,AC,AH,2A,2S,2D,2H,3A,3S,3D,3H,4A,4S,4D,4H,5A,5S,5D,5H,6A,6S,6D,6H,7A,7S,7D,7H,8A,8S,8D,8H,9A,9S,9D,9H,10A,10S,10D,10H';

  Future<DeckModel> newDeck([int deckCount = 1]) async {
    final data = await httpGet(
      '/deck/new/shuffle',
      params: {'cards': cards, 'deck_count': deckCount},
    );

    return DeckModel.fromJson(data);
  }

  Future<DrawModel> drawCards(DeckModel deck, {int count = 1}) async {
    final data = await httpGet(
      '/deck/${deck.deck_id}/draw',
      params: {'count': count},
    );

    return DrawModel.fromJson(data);
  }
}
