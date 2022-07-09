import 'dart:async';

import 'package:flutter_mvvm/domain/artists_repository.dart';
import 'package:flutter_mvvm/view/base/base_view_model.dart';
import 'package:flutter_mvvm/view/base/resource_state.dart';
import 'package:flutter_mvvm/view/common/errorhandling/app_action.dart';
import 'package:flutter_mvvm/view/errorbuilder/artists_error_builder.dart';

import '../../data/artists/artists_data_impl.dart';

class ArtistsViewModel extends BaseViewModel {
  final ArtistsRepository _artistsRepository = ArtistsDataImpl();

  StreamController<ResourceState> artistsState =
      StreamController<ResourceState>();

  Future<void> fetchArtists() async {
    artistsState.add(ResourceState.loading());

    _artistsRepository
        .getArtists()
        .then((value) => artistsState.add(ResourceState.completed(value)))
        .catchError((e) {
          artistsState.add(ResourceState.error(
              ArtistsErrorBuilder.create(e, AppAction.GET_ARTISTS).build()));
        });
  }

  @override
  void dispose() {
    artistsState.close();
  }
}
