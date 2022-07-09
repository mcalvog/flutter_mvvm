library light_sliver_view;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightSliverView extends StatefulWidget {
  final String title;
  final Widget? expandedContent;
  final Widget? content;
  final bool? lightContent;
  final double? expandedHeight;
  final bool? centerTitle;
  final List<Widget>? actions;
  final bool? darkModeSupport;
  final bool? useSurfaceTintColor;

  const LightSliverView(
      {Key? key,
      required this.title,
      this.expandedContent,
      this.content,
      this.lightContent,
      this.expandedHeight,
      this.centerTitle,
      this.actions,
      this.darkModeSupport,
      this.useSurfaceTintColor})
      : super(key: key);

  @override
  State<LightSliverView> createState() => _LightSliverViewState();
}

class _LightSliverViewState extends State<LightSliverView> {
  late ScrollController _scrollController;
  late Color _theme;
  late SystemUiOverlayStyle _systemOverlay;
  late String _title;

  double get expandedHeight {
    return widget.expandedHeight ?? 200;
  }

  bool get lightContentEnabled {
    return widget.lightContent != false && !_isDarkMode;
  }

  bool get _isAppBarCollapsed {
    return _scrollController.hasClients &&
        _scrollController.offset > (expandedHeight - kToolbarHeight - 20) &&
        lightContentEnabled;
  }

  @override
  void initState() {
    super.initState();

    _theme = Colors.white;
    _systemOverlay = SystemUiOverlayStyle.light;
    _title = '';

    _scrollController = ScrollController()
      ..addListener(() => {
            setState(() {
              _theme = _isAppBarCollapsed ? Colors.black : Colors.white;
              _systemOverlay = _isAppBarCollapsed
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light;
              _title = _isAppBarCollapsed ? widget.title : '';
            })
          });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(
            color: _theme,
          ),
          systemOverlayStyle: _systemOverlay,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: widget.useSurfaceTintColor == true
              ? Theme.of(context).colorScheme.surfaceTint
              : Theme.of(context).scaffoldBackgroundColor,
          pinned: true,
          expandedHeight: expandedHeight,
          centerTitle: widget.centerTitle ?? false,
          title: Text(
            _title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: _theme),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: widget.expandedContent ?? Container(),
          ),
          actions: widget.actions ?? [],
        ),
        widget.content ?? const SliverFillRemaining()
      ],
    );
  }

  bool get _isDarkMode {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark && widget.darkModeSupport == true;
  }
}
