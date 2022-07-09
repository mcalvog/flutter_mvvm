import 'package:flutter_mvvm/data/artists/remote/artists_remote_impl.dart';
import 'package:flutter_mvvm/domain/artists_repository.dart';
import 'package:flutter_mvvm/model/artist.dart';

class ArtistsDataImpl implements ArtistsRepository {
  final ArtistsRemoteImpl _remoteImpl = ArtistsRemoteImpl();

  @override
  Future<List<Artist>> getArtists() {
    return _remoteImpl.getArtists();
  }
}
