// lib/main.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class Song {
  final String title;
  final String artist;
  final String url;
  final int durationSeconds; // fallback duration in seconds

  Song({
    required this.title,
    required this.artist,
    required this.url,
    required this.durationSeconds,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleMusicPlayer(),
    );
  }
}

class SimpleMusicPlayer extends StatefulWidget {
  const SimpleMusicPlayer({super.key});

  @override
  State<SimpleMusicPlayer> createState() => _SimpleMusicPlayerState();
}

class _SimpleMusicPlayerState extends State<SimpleMusicPlayer> {
  final AudioPlayer _player = AudioPlayer();

  // Hard-coded playlist (at least 3 songs)
  final List<Song> _playlist = [
    Song(
      title: 'SoundHelix Song 1',
      artist: 'SoundHelix',
      url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      durationSeconds: 345,
    ),
    Song(
      title: 'SoundHelix Song 2',
      artist: 'SoundHelix',
      url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      durationSeconds: 285,
    ),
    Song(
      title: 'SoundHelix Song 3',
      artist: 'SoundHelix',
      url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      durationSeconds: 300,
    ),
  ];

  int _currentIndex = 0;
  Duration _duration = Duration.zero; // actual duration from player
  Duration _position = Duration.zero; // current position
  bool _isPlaying = false;
  bool _isSourceSet = false; // track if setSource was called for current song

  @override
  void initState() {
    super.initState();
    _setupPlayer();
    _loadSong(_currentIndex, autoPlay: false);
  }

  void _setupPlayer() {
    // duration updates
    _player.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    // position updates
    _player.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    // when a song completes -> go to next (circular)
    _player.onPlayerComplete.listen((_) {
      _handleNext();
    });

    // track playing state
    _player.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  Future<void> _loadSong(int index, {bool autoPlay = true}) async {
    final song = _playlist[index];
    try {
      // set source
      await _player.setSource(UrlSource(song.url));
      _isSourceSet = true;

      // if player hasn't reported a duration yet, fallback to model's duration
      if (_duration == Duration.zero) {
        setState(() {
          _duration = Duration(seconds: song.durationSeconds);
        });
      }

      // reset position
      setState(() {
        _position = Duration.zero;
      });

      if (autoPlay) {
        await _player.resume();
      } else {
        // ensure not playing
        await _player.pause();
      }
    } catch (e) {
      // show error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading "${song.title}": $e')),
        );
      }
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _handlePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      // if no source set (first time) then load current song
      if (!_isSourceSet) {
        await _loadSong(_currentIndex, autoPlay: true);
      } else {
        await _player.resume();
      }
    }
  }

  Future<void> _handleNext() async {
    final next = (_currentIndex + 1) % _playlist.length;
    setState(() => _currentIndex = next);
    // clear previous duration/position before loading new
    setState(() {
      _duration = Duration.zero;
      _position = Duration.zero;
      _isSourceSet = false;
    });
    await _loadSong(_currentIndex, autoPlay: true);
  }

  Future<void> _handlePrevious() async {
    final prev = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    setState(() => _currentIndex = prev);
    setState(() {
      _duration = Duration.zero;
      _position = Duration.zero;
      _isSourceSet = false;
    });
    await _loadSong(_currentIndex, autoPlay: true);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = _playlist[_currentIndex];
    final total = _duration > Duration.zero ? _duration : Duration(seconds: currentSong.durationSeconds);

    double sliderValue = 0.0;
    if (total.inMilliseconds > 0) {
      sliderValue = _position.inMilliseconds / total.inMilliseconds;
      if (sliderValue.isNaN || sliderValue.isInfinite) sliderValue = 0.0;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Simple Music Player')),
      body: Column(
        children: [
          // Top player section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      currentSong.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currentSong.artist,
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    // Slider + times
                    Column(
                      children: [
                        Slider(
                          value: sliderValue.clamp(0.0, 1.0),
                          onChanged: (v) async {
                            if (total.inMilliseconds > 0) {
                              final seekPos = Duration(milliseconds: (total.inMilliseconds * v).round());
                              await _player.seek(seekPos);
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDuration(_position)),
                            Text(_formatDuration(total)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 36,
                          onPressed: _handlePrevious,
                          icon: const Icon(Icons.skip_previous),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          iconSize: 56,
                          onPressed: _handlePlayPause,
                          icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          iconSize: 36,
                          onPressed: _handleNext,
                          icon: const Icon(Icons.skip_next),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Playlist title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Playlist', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),

          // Song list
          Expanded(
            child: ListView.builder(
              itemCount: _playlist.length,
              itemBuilder: (context, index) {
                final song = _playlist[index];
                final selected = index == _currentIndex;
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(song.title),
                  subtitle: Text(song.artist),
                  selected: selected,
                  onTap: () async {
                    setState(() => _currentIndex = index);
                    setState(() {
                      _duration = Duration.zero;
                      _position = Duration.zero;
                      _isSourceSet = false;
                    });
                    await _loadSong(index, autoPlay: true);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
