import 'package:street_casino/services/api_service.dart';

class DeckService extends ApiService{

  Future<void> newDeck([int deckCount = 1]) async {
    final data = await httpGet(
      '/deck/new/shuffle',
      params: {
        'deck_count': deckCount
      },
    );
  }

}