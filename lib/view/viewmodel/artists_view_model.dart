import 'dart:async';

import 'package:flutter_mvvm/domain/artists_repository.dart';
import 'package:flutter_mvvm/view/base/base_view_model.dart';
import 'package:flutter_mvvm/view/base/resource_state.dart';
import 'package:flutter_mvvm/view/common/errorhandling/app_action.dart';
import 'package:flutter_mvvm/view/errorbuilder/artists_error_builder.dart';

class ArtistsViewModel extends BaseViewModel {
  final ArtistsRepository _artistsRepository;

  ArtistsViewModel(this._artistsRepository);

  final StreamController<ResourceState> _artistsState =
      StreamController<ResourceState>();
  Stream<ResourceState> get artistsState => _artistsState.stream;

  Future<void> fetchArtists() async {
    _artistsState.sink.add(ResourceState.loading());

    _artistsRepository
        .getArtists()
        .then((value) => _artistsState.sink.add(ResourceState.completed(value)))
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
