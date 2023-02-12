import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/artist.dart';
import 'package:flutter_mvvm/presentation/common/widget/light_sliver_view.dart';

import '../../common/resources/app_dimens.dart';

class ArtistDetailPage extends StatefulWidget {
  final Artist artist;

  const ArtistDetailPage({Key? key, required this.artist}) : super(key: key);

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LightSliverView(
        title: widget.artist.name,
        centerTitle: true,
        expandedHeight: AppDimens.sliverExpandedHeight,
        expandedContent: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: widget.artist.id,
              child: Container(
                color: Colors.black,
                child: Image(
                  image: CachedNetworkImageProvider(widget.artist.avatar),
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
                    widget.artist.name,
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
              child: Text(widget.artist.title,
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
