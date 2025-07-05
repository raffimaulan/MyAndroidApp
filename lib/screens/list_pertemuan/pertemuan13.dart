import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class Pertemuan13 extends StatefulWidget {
  const Pertemuan13({super.key});

  @override
  State<Pertemuan13> createState() => _Pertemuan13State();
}

class _Pertemuan13State extends State<Pertemuan13> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _videoController = VideoPlayerController.asset('assets/videoplayback.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void _playPauseAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(
        AssetSource('assets/Chill · Jazzy · Beats by Snoozy Beats No Copyright Music Doing Good.mp3'),
      );
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _playPauseVideo() {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
      } else {
        _videoController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : const Color(0xFF00C29B);
    final cardColor = isDark ? Colors.grey[850] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Pertemuan 13',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // AUDIO PLAYER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: const Color(0xFF00C29B).withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.music_note_rounded, color: Colors.pink, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chill · Jazzy · Beats by Snoozy Beats No Copyright Music Doing Good.mp3',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Jazzy',
                          style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _playPauseAudio,
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    label: Text(
                      isPlaying ? 'Pause' : 'Play',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C29B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            // VIDEO PLAYER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'videoplayback.mp4',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'play back',
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  _videoController.value.isInitialized
                      ? Center(
                          child: Container(
                            width: 600,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  VideoPlayer(_videoController),
                                  VideoProgressIndicator(
                                    _videoController,
                                    allowScrubbing: true,
                                    colors: VideoProgressColors(
                                      playedColor: const Color(0xFF00C29B),
                                      bufferedColor: const Color(0xFF00C29B),
                                      backgroundColor: Colors.grey[300]!,
                                    ),
                                  ),
                                  Center(
                                    child: IconButton(
                                      icon: Icon(
                                        _videoController.value.isPlaying
                                            ? Icons.pause_circle_filled
                                            : Icons.play_circle_fill,
                                        size: 48,
                                        color: const Color(0xFF00C29B),
                                      ),
                                      onPressed: _playPauseVideo,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
