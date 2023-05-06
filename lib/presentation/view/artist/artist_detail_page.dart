import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/artist.dart';
import 'package:flutter_mvvm/presentation/common/widget/light_sliver_view.dart';

import '../../common/resources/app_dimens.dart';

class ArtistDetailPageArguments {
  final Artist artist;
  ArtistDetailPageArguments(this.artist);
}

class ArtistDetailPage extends StatefulWidget {

  const ArtistDetailPage({Key? key}) : super(key: key);

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArtistDetailPageArguments;

    return Scaffold(
      body: LightSliverView(
        title: args.artist.name,
        centerTitle: true,
        expandedHeight: AppDimens.sliverExpandedHeight,
        expandedContent: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: args.artist.id,
              child: Container(
                color: Colors.black,
                child: Image(
                  image: CachedNetworkImageProvider(args.artist.avatar),
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.8),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.mediumMargin),
                  child: Text(
                    args.artist.name,
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        content: SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.mediumMargin),
              child: Text(args.artist.title,
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {
              // You can use Share Plus package to share content
              // https://pub.dev/packages/share_plus
            },
          ),
        ],
      ),
    );
  }
}
