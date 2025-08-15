// dart
import 'package:flutter/material.dart';

// functions
import 'package:kikoeru/pages/WorkDetail/logic/ItemImageViewEvent.dart';

class ItemImageView extends StatefulWidget {
  final String title;
  final String url;
  const ItemImageView({super.key, required this.title, required this.url});

  @override
  State<ItemImageView> createState() => _ItemImageViewState();
}

class _ItemImageViewState extends State<ItemImageView> {
  final TransformationController _controller = TransformationController();
  final double _zoom = 2.0;
  TapDownDetails? _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: GestureDetector(
          child: InteractiveViewer(
            transformationController: _controller,
            minScale: 1.0,
            maxScale: 4.0,
            panEnabled: true,
            scaleEnabled: true,
            child: Image.network(widget.url, fit: BoxFit.contain),
          ),
          onLongPress: () async => handleLongPress(
            context,
            widget.title,
            widget.url,
          ),
          onDoubleTapDown: (details) => _doubleTapDetails = details,
          onDoubleTap: () => handleDoubleTap(
            _controller,
            _zoom,
            _doubleTapDetails,
          ),
        ),
      ),
    );
  }
}
