import 'package:flutter_mvvm/model/artist.dart';

abstract class ArtistsRepository {
  Future<List<Artist>> getArtists();
}
