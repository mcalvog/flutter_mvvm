import 'dart:async';

import 'package:flutter_mvvm/domain/artists_repository.dart';
import 'package:flutter_mvvm/model/artist.dart';
import 'package:flutter_mvvm/presentation/common/base/base_view_model.dart';
import 'package:flutter_mvvm/presentation/common/base/resource_state.dart';
import 'package:flutter_mvvm/presentation/common/errorhandling/app_action.dart';
import 'package:flutter_mvvm/presentation/view/artist/viewmodel/artists_error_builder.dart';

class ArtistsViewModel extends BaseViewModel {
  final ArtistsRepository _artistsRepository;

  ArtistsViewModel(this._artistsRepository);

  final StreamController<ResourceState<List<Artist>>> _artistsState =
      StreamController();

  Stream<ResourceState<List<Artist>>> get artistsState => _artistsState.stream;

  Future<void> fetchArtists() async {
    _artistsState.sink.add(ResourceState.loading());

    _artistsRepository
        .getArtists()
        .then((value) => _artistsState.sink.add(ResourceState.success(value)))
        .catchError((e) {
      _artistsState.sink.add(ResourceState.error(
          ArtistsErrorBuilder.create(e, AppAction.GET_ARTISTS).build()));
    });
  }

  @override
  void dispose() {
    _artistsState.close();
  }
}
