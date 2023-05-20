import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'widgets/flash_mode_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isSelfieMode = false;

  late FlashMode _flashMode;
  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;
    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else {
      _deniedPermission = true;
      //이건 아니지 권한을 허용해 달라구.
    }
  }

  @override
  void initState() {
    initPermission();
    super.initState();
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // 권한을 가지고 있지 않거나 카메라가 초기화 되지 않았으면
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _deniedPermission
                      ? const Column(
                          children: [
                            Text(
                              "셋팅으로 가서 카메라와 마이크를 허용해 주세요...",
                              style: TextStyle(
                                  color: Colors.white, fontSize: Sizes.size20),
                            ),
                            Gaps.v20,
                            CircularProgressIndicator.adaptive(),
                          ],
                        )
                      : const Column(
                          children: [
                            Text(
                              "Initializing...",
                              style: TextStyle(
                                  color: Colors.white, fontSize: Sizes.size20),
                            ),
                            Gaps.v20,
                            CircularProgressIndicator.adaptive(),
                          ],
                        )
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                      top: Sizes.size20,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: _toggleSelfieMode,
                            icon: const Icon(
                              Icons.cameraswitch,
                            ),
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            flashMode: _flashMode,
                            flashType: FlashMode.off,
                            setFlashMode: _setFlashMode,
                            iconData: Icons.flash_off_rounded,
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            flashMode: _flashMode,
                            flashType: FlashMode.always,
                            setFlashMode: _setFlashMode,
                            iconData: Icons.flash_on_rounded,
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            flashMode: _flashMode,
                            flashType: FlashMode.auto,
                            setFlashMode: _setFlashMode,
                            iconData: Icons.flash_auto_rounded,
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            flashMode: _flashMode,
                            flashType: FlashMode.torch,
                            setFlashMode: _setFlashMode,
                            iconData: Icons.flashlight_on_rounded,
                          ),
                        ],
                      )),
                ],
              ),
      ),
    );
  }
}
