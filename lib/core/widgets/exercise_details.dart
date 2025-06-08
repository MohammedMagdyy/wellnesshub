import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../helper_functions/build_customSnackbar.dart';
import '../models/fitness_plan/exercises_model.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../services/workout_plan/done_service.dart';

class ExerciseDetails extends StatefulWidget {
  final Exercise exercise;
  final int? weekId;
  final int? dayId;
  const ExerciseDetails({
    super.key,
    required this.exercise,
    this.weekId,
    this.dayId,
  });

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitializing = true;
  bool _hasError = false;


  @override
  void initState() {
    super.initState();
    print(widget.dayId);
    print(widget.weekId);
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      // Use the exercise's video URL or fallback to default
      final videoUrl = widget.exercise.videoUrl ??
          widget.exercise.videoUrl;

      _videoPlayerController = VideoPlayerController.network(videoUrl!);

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.grey[300]!,
        ),
        placeholder: Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 50, color: Colors.red),
                const SizedBox(height: 10),
                Text(
                  'Failed to load video',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
          );
        },
      );

      setState(() {
        _isInitializing = false;
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _isInitializing = false;
        _hasError = true;
      });
    }
  }

  @override
  void didUpdateWidget(ExerciseDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exercise.videoUrl != widget.exercise.videoUrl) {
      _disposeVideoControllers();
      _initializeVideoPlayer();
    }
  }

  void _disposeVideoControllers() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
  }

  @override
  void dispose() {
    _disposeVideoControllers();
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
          // Video Player Section
          if (_isInitializing)
            const SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_hasError || _chewieController == null)
            Container(
              height: 500,
              color: Colors.grey[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 50, color: Colors.red),
                    const SizedBox(height: 10),
                    const Text('Failed to load video'),
                    TextButton(
                      onPressed: _initializeVideoPlayer,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else
            AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: Chewie(controller: _chewieController!),
            ),

          // Exercise Details Section
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
          Text("dayId: ${widget.dayId}"),
          const SizedBox(height: 10),
          Text("weekId: ${widget.weekId}"),
          const SizedBox(height: 10),
          Text("Sets: ${exercise.sets}"),
          const SizedBox(height: 10),
          Text("Target Muscle: ${exercise.targetMuscle}"),
          const SizedBox(height: 10),
          Text("Description:\n${exercise.description ?? 'No description available'}"),
          const SizedBox(height: 20),
          CustomButton(
            name: exercise.exerciseDone ?? false ? "Completed" : "Done",
            color: Colors.white,
            width: double.infinity,
              on_Pressed: () async {
                DoneService doneService = DoneService();
                try {
                  final result = await doneService.exerciseDone(
                    widget.exercise.id,
                    widget.weekId!,
                    widget.dayId!,
                  );

                  // Show success snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    buildCustomSnackbar(
                      title: "Success",
                      message: result['message'] ?? "Exercise marked as done!",
                      type: ContentType.success,
                      backgroundColor: Colors.green,
                    ),
                  );
                  setState(() {
                     exercise.exerciseDone=true;   // Update local model
                  });
                  Navigator.pushReplacementNamed(context, 'FitnessPlanPage');
                  setState(() {
                    
                  });

                } catch (e) {
                  // Show error snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    buildCustomSnackbar(
                      title: "Error",
                      message: e.toString(),
                      type: ContentType.failure,
                      backgroundColor: Colors.red,
                    ),
                  );
                  Navigator.pop(context);
                }
              }

          ),
        ],
      ),
    );
  }
}