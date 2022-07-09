import 'package:flutter_mvvm/data/remote/base/serializer/base_serializer.dart';
import 'package:flutter_mvvm/model/artist.dart';

class ArtistSerializer extends BaseSerializer<Artist> {
  @override
  Artist fromJson(Map<String, dynamic> data) {
    return Artist(data['id'], data['name'], data['title'], data['avatar']);
  }

  @override
  Map<String, dynamic> toJson(Artist data) {
    return {
      'id': data.id,
      'name': data.name,
      'title': data.title,
      'avatar': data.avatar
    };
  }

  List<Artist> listFromJson(dynamic response) {
    return response.data['items']
        .map<Artist>((data) => fromJson(data))
        .toList();
  }
}
