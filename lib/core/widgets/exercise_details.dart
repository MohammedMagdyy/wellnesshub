import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../models/fitness_plan/exercises_model.dart';

class ExerciseDetails extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDetails({super.key, required this.exercise});

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  String? _currentUrl;
  late VideoPlayerController _controller;

  @override
  void initState() {
    print("INIT VIDEO CONTROLLER");
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    if (_currentUrl == widget.exercise.videoUrl) return;

    _currentUrl = widget.exercise.videoUrl;
    _controller = VideoPlayerController.network( 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    print("DISPOSE VIDEO CONTROLLER");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _controller.value.isInitialized
              ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    size: 80,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          )
              : const Center(child: CircularProgressIndicator()),


          const SizedBox(height: 30),
          Text(
            exercise.exerciseName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Text("Sets: ${exercise.sets}"),
          const SizedBox(height: 10),
          Text("Target Muscle: ${exercise.targetMuscle}"),
          const SizedBox(height: 10),
          Text("Description:\n "
              "${ exercise.description}"),
          const SizedBox(height: 20),
          CustomButton(
            name: exercise.exerciseDone ? "Completed" : "Done",
            color: Colors.white,
            width: double.infinity,
            on_Pressed: () {
              // Handle update
            },
          ),
        ],
      ),
    );
  }
}
