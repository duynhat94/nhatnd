import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final Player player;
  late final VideoController controller;
  StreamSubscription<bool>? _playingSubscription;

  // URL HLS của bạn
  final String hlsUrl = 'https://play.cloudbeta.win/file/play/74840769-1e99-46eb-802f-da0934a4b6f2.m3u8';

  bool _isPlaying = false;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();

    // 1. Khởi tạo Player với cấu hình tắt tiếng để autoplay trên web
    player = Player(configuration: const PlayerConfiguration(vo: 'mediacodec_embed'));
    controller = VideoController(
      player,
      configuration: VideoControllerConfiguration(vo: 'mediacodec_embed', hwdec: 'mediacodec'),
    );

    // 2. Lắng nghe trạng thái 'playing' để cập nhật UI
    _playingSubscription = player.stream.playing.listen((isPlaying) {
      if (mounted) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
    });
    play();
  }

  Future<void> play() async {
    await player.open(
      Media(hlsUrl),
      play: false, // Yêu cầu tự động phát
    );
  }

  @override
  void dispose() {
    _playingSubscription?.cancel();
    player.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    player.setVolume(_isMuted ? 0.0 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playing HLS (.m3u8) Stream')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 9.0 / 16.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Video(controller: controller),

                // Hiển thị loading indicator cho đến khi video thực sự bắt đầu phát
                if (!_isPlaying) const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Nút để bật/tắt tiếng
          IconButton(
            icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
            onPressed: _toggleMute,
            tooltip: _isMuted ? 'Unmute' : 'Mute',
          ),
        ],
      ),
    );
  }
}
