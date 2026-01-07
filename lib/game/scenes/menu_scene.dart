import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class MenuScene extends Component with HasGameRef, Tappable {
  late TextComponent title;
  late TextComponent playButton;
  late TextComponent levelSelectButton;
  late TextComponent settingsButton;
  late RectComponent background;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadBackground();
    _loadTitle();
    _loadPlayButton();
    _loadLevelSelectButton();
    _loadSettingsButton();
  }

  void _loadBackground() {
    background = RectComponent(
      position: Vector2.zero(),
      size: gameRef.size,
      paint: Paint()..color = Colors.lightBlueAccent,
    );
    add(background);
  }

  void _loadTitle() {
    title = TextComponent(
      text: 'Batch-20260107-124849-puzzle-01',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 4),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold)),
    );
    add(title);
  }

  void _loadPlayButton() {
    playButton = TextComponent(
      text: 'Play',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20.0, color: Colors.white)),
    )..additionalPaint = Paint()..color = Colors.green;
    playButton.add(RectangleHitbox()..onTap = () => _onPlayButtonPressed());
    add(playButton);
  }

  void _loadLevelSelectButton() {
    levelSelectButton = TextComponent(
      text: 'Levels',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2 + 50),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20.0, color: Colors.white)),
    )..additionalPaint = Paint()..color = Colors.blue;
    levelSelectButton.add(RectangleHitbox()..onTap = () => _onLevelSelectButtonPressed());
    add(levelSelectButton);
  }

  void _loadSettingsButton() {
    settingsButton = TextComponent(
      text: 'Settings',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2 + 100),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20.0, color: Colors.white)),
    )..additionalPaint = Paint()..color = Colors.orange;
    settingsButton.add(RectangleHitbox()..onTap = () => _onSettingsButtonPressed());
    add(settingsButton);
  }

  void _onPlayButtonPressed() {
    // Implement navigation to the game play scene
    print('Play button pressed');
  }

  void _onLevelSelectButtonPressed() {
    // Implement navigation to the level select scene
    print('Level select button pressed');
  }

  void _onSettingsButtonPressed() {
    // Implement navigation to the settings scene
    print('Settings button pressed');
  }

  @override
  bool onTapUp(TapUpInfo info) {
    return super.onTapUp(info);
  }
}