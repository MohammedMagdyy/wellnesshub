import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../helper_class/favourite_manager.dart';
import '../helper_functions/build_customSnackbar.dart';
import '../models/fitness_plan/exercises_model.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../services/workout_plan/done_service.dart';

class ExerciseDetails extends StatefulWidget {
  final Exercise exercise;
  final int? weekId;
  final int? dayId;
  final bool plan;
  final bool isFav;
  const ExerciseDetails({
    super.key,
    required this.exercise,
    required this.plan,
    required this.isFav,
    this.weekId,
    this.dayId,
  });

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  bool isFavorited = false;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitializing = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();

    // Initialize favorite status
    isFavorited = FavoriteManager.instance.isFavorite(widget.exercise.id);

    // Listen for changes in favorites to update UI reactively
    FavoriteManager.instance.favorites.addListener(_favoritesListener);
  }

  void _favoritesListener() {
    final currentlyFavorited = FavoriteManager.instance.isFavorite(widget.exercise.id);
    if (currentlyFavorited != isFavorited) {
      setState(() {
        isFavorited = currentlyFavorited;
      });
    }
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      final videoUrl = widget.exercise.videoUrl ?? widget.exercise.videoUrl;

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
  void _FavouriteActionFunc()async{
    try {
      if (isFavorited) {
        await FavoriteManager.instance.removeFavorite(widget.exercise);
      } else {
        await FavoriteManager.instance.addFavorite(widget.exercise);
      }
      // FavoriteManager updates state internally; no manual reload needed
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackbar(
          title: "Error",
          message: e.toString(),
          type: ContentType.failure,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _disposeVideoControllers();
    FavoriteManager.instance.favorites.removeListener(_favoritesListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isDark? darkBmiContainerColor : lightBmiContainerColor,
              border: Border.all(
                color: isDark? darkCardBorderColor : lightCardBorderColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  exercise.exerciseName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark? darkBmiTextColor_1 : lightBmiTextColor_1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(exercise.sets , style: TextStyle(
                  color: isDark? darkBmiTextColor_2 : lightBmiTextColor_2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text("Target Muscle: ${exercise.targetMuscle}"
                  , style: TextStyle(
                      color: isDark? darkBmiTextColor_3 : lightBmiTextColor_3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                  // textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                Text("Description:\n${exercise.description ?? 'No description available'}"
                  , style: TextStyle(
                      color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  name:widget.isFav==true?"Back":( exercise.exerciseDone == true ? "Completed" : "Done"),
                  color: exercise.exerciseDone == true ? Colors.grey : Colors.white,
                  width: double.infinity,
                  on_Pressed: exercise.exerciseDone == true ? null : () async {
                    if (widget.plan == false) {

                      Navigator.pop(context, true);
                    } else {
                      DoneService doneService = DoneService();
                      if (exercise.exerciseDone != true) {
                        try {
                          final result = await doneService.exerciseDone(
                            widget.exercise.id,
                            widget.weekId!,
                            widget.dayId!,
                          );

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   buildCustomSnackbar(
                          //     title: "",
                          //     message: "Exercise marked as done!",
                          //     type: ContentType.success,
                          //     backgroundColor: Colors.green,
                          //   ),
                          // );

                          setState(() {
                            exercise.exerciseDone = true;
                          });

                          Navigator.pop(context, true);
                        } catch (e) {
                          print("Error marking exercise as done: ${e.toString()}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            buildCustomSnackbar(
                              title: "Error",
                              message: "Failed to mark exercise as done.",
                              type: ContentType.failure,
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        Navigator.pop(context, false);
                      }
                    }
                  },
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: IconButton(
                  key: ValueKey<bool>(isFavorited),
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited ? Colors.red : Colors.grey,
                    size: 40,
                  ),
                  onPressed: () async {
                    _FavouriteActionFunc();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
