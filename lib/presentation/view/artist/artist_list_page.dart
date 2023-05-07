import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/artist.dart';
import 'package:flutter_mvvm/presentation/common/base/resource_state.dart';
import 'package:flutter_mvvm/presentation/common/widget/error/error_overlay.dart';
import 'package:flutter_mvvm/presentation/common/widget/loading/loading_overlay.dart';
import 'package:flutter_mvvm/presentation/navigation/navigation_routes.dart';
import 'package:flutter_mvvm/presentation/view/artist/viewmodel/artists_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../../di/app_modules.dart';
import '../../common/localization/localization.dart';

class ArtistListPage extends StatefulWidget {
  const ArtistListPage({Key? key}) : super(key: key);

  @override
  State<ArtistListPage> createState() => _ArtistListPageState();
}

class _ArtistListPageState extends State<ArtistListPage>
    with AutomaticKeepAliveClientMixin {
  final viewModel = inject<ArtistsViewModel>();
  List<Artist> data = List.empty();

  @override
  void initState() {
    super.initState();

    viewModel.artistsState.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.SUCCESS:
          LoadingOverlay.hide();
          setState(() {
            data = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context)
              .show(state.error, onRetry: () => viewModel.fetchArtists());
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    viewModel.fetchArtists();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).string('artists_title')),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final artist = data[index];

            return ListTile(
              title: Text(artist.name),
              subtitle: Text(artist.title),
              leading: Hero(
                tag: artist.id,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(artist.avatar),
                ),
              ),
              onTap: (() => context.push(NavigationRoutes.artistDetailRoute,
                  extra: artist)),
            );
          },
        ),
        onRefresh: () async {
          viewModel.fetchArtists();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose(); // Avoid memory leaks
  }

  @override
  bool get wantKeepAlive => true;
}
