import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeButton extends StatelessWidget {
  const FlashModeButton({
    super.key,
    required this.flashMode,
    required this.flashType,
    required this.setFlashMode,
    required this.iconData,
  });

  final FlashMode flashMode;
  final FlashMode flashType;
  final IconData iconData;
  final Future<void> Function(FlashMode newFlashMode) setFlashMode;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: flashMode == flashType ? Colors.amber.shade200 : Colors.white,
      onPressed: () => setFlashMode(flashType),
      icon: Icon(
        iconData,
      ),
    );
  }
}
