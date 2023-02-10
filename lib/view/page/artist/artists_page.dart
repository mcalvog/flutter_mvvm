import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/artist.dart';
import 'package:flutter_mvvm/view/common/base/resource_state.dart';
import 'package:flutter_mvvm/view/common/navigation/navigation_extensions.dart';
import 'package:flutter_mvvm/view/page/artist/artist_detail_page.dart';
import 'package:flutter_mvvm/view/page/artist/viewmodel/artists_view_model.dart';
import 'package:flutter_mvvm/view/widget/error/error_overlay.dart';
import 'package:flutter_mvvm/view/widget/loading/loading_overlay.dart';

import '../../common/localization/localization.dart';
import '../../di/app_modules.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage>
    with AutomaticKeepAliveClientMixin {
  final viewModel = inject<ArtistsViewModel>();
  List<Artist> data = List.empty();

  @override
  void initState() {
    super.initState();

    viewModel.artistsState.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.of(context).show();
          break;
        case Status.COMPLETED:
          LoadingOverlay.of(context).hide();
          setState(() {
            data = state.data;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.of(context).hide();
          ErrorOverlay.of(context)
              .show(state.error, onRetry: () => viewModel.fetchArtists());
          break;
        default:
          LoadingOverlay.of(context).hide();
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
              onTap: (() =>
                  {context.navigateTo(ArtistDetailPage(artist: artist))}),
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
