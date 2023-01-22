import 'package:flutter_mvvm/data/artists/serializer/artist_serializer.dart';
import 'package:flutter_mvvm/data/remote/base/error/remote_error_mapper.dart';
import 'package:flutter_mvvm/data/remote/http_client.dart';
import 'package:flutter_mvvm/data/remote/network_endpoints.dart';
import 'package:flutter_mvvm/model/artist.dart';

class ArtistsRemoteImpl {
  final ArtistSerializer _artistSerializer;
  final HttpClient _httpClient;

  ArtistsRemoteImpl(this._httpClient, this._artistSerializer);

  Future<List<Artist>> getArtists() async {
    try {
      dynamic response = await _httpClient.dio.get(NetworkEndpoints.artistsUrl);

      return _artistSerializer.listFromJson(response);
    } on Exception catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
