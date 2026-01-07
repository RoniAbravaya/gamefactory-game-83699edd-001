import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'game_state.dart';
import 'level_config.dart';
import 'score_system.dart';
import 'lives_system.dart';
import 'game_controller.dart';
import 'analytics_service.dart';
import 'ui_overlay.dart';

/// The main FlameGame class for the Batch-20260107-124849-puzzle-01 game.
class Batch-20260107-124849-puzzle-01Game extends FlameGame with TapDetector {
  /// The current game state.
  GameState _gameState = GameState.playing;

  /// The score system.
  final ScoreSystem _scoreSystem = ScoreSystem();

  /// The lives system.
  final LivesSystem _livesSystem = LivesSystem();

  /// The game controller.
  final GameController _gameController = GameController();

  /// The analytics service.
  final AnalyticsService _analyticsService = AnalyticsService();

  /// The UI overlay.
  final UIOverlay _uiOverlay = UIOverlay();

  @override
  Future<void> onLoad() async {
    // Set up the camera and world
    camera.viewport = FixedResolutionViewport(Vector2(800, 600));
    camera.followComponent(_gameController);

    // Load the initial level
    await _loadLevel(1);

    // Add the UI overlay
    add(_uiOverlay);
  }

  /// Loads the specified level.
  Future<void> _loadLevel(int levelNumber) async {
    // Load the level configuration
    final levelConfig = await LevelConfig.load(levelNumber);

    // Add the level components to the game
    // ...

    // Update the game state
    _gameState = GameState.playing;

    // Log the level start event
    _analyticsService.logLevelStart(levelNumber);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the game state and systems
    switch (_gameState) {
      case GameState.playing:
        _gameController.update(dt);
        _scoreSystem.update(dt);
        _livesSystem.update(dt);
        break;
      case GameState.paused:
        // Pause the game
        break;
      case GameState.gameOver:
        // Handle game over
        break;
      case GameState.levelComplete:
        // Handle level completion
        break;
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    _gameController.handleTap(info.eventPosition.game);
  }

  /// Handles a successful tile swap.
  void _handleTileSwap() {
    // Update the score
    _scoreSystem.incrementScore();

    // Check for level completion
    if (_scoreSystem.score >= _levelConfig.targetScore) {
      _gameState = GameState.levelComplete;
      _analyticsService.logLevelComplete();
    }
  }

  /// Handles a failed tile swap.
  void _handleTileSwapFail() {
    // Decrement the player's lives
    _livesSystem.decrementLives();

    // Check for game over
    if (_livesSystem.lives <= 0) {
      _gameState = GameState.gameOver;
      _analyticsService.logLevelFail();
    }
  }
}