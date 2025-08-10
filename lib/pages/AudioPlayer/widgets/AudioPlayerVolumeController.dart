// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:volume_controller/volume_controller.dart';

class AudioPlayerVolumeController extends StatefulWidget {
  const AudioPlayerVolumeController({super.key});

  @override
  State<AudioPlayerVolumeController> createState() =>
      _AudioPlayerVolumeControllerState();
}

class _AudioPlayerVolumeControllerState
    extends State<AudioPlayerVolumeController> {
  VolumeController volumeInstance = VolumeController.instance;
  double volume = 0;

  @override
  void initState() {
    super.initState();
    volumeInstance.getVolume().then((v) {
      if (mounted) {
        setState(() {
          volume = v;
        });
      }
    });
    volumeInstance.addListener((v) {
      if (mounted) {
        setState(() {
          volume = v;
        });
      }
    });
  }

  @override
  void dispose() {
    volumeInstance.removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.volume_down_alt,
          size: 32,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 150,
          child: Scrollbar(
            child: Slider(
              value: volume,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: ((volume) * 100).toInt().toString(),
              onChanged: (value) async {
                await volumeInstance.setVolume(value);
              },
            ),
          ),
        ),
        Icon(
          Icons.volume_up,
          size: 32,
        ),
      ],
    );
  }
}
