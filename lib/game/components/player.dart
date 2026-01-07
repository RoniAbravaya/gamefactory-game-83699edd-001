import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

/// Represents the player in the puzzle game, handling animations, movement, and game mechanics like scoring.
class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable, KeyboardHandler {
  // Player states
  bool isMoving = false;
  Vector2 direction = Vector2.zero();
  final double speed = 200.0;
  int lives = 3;
  int score = 0;

  // Animations
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation movingAnimation;

  Player()
      : super(size: Vector2.all(50.0), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Assuming animations are loaded here
    idleAnimation = await _loadAnimation('idle');
    movingAnimation = await _loadAnimation('moving');
    animation = idleAnimation;
    addShape(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isMoving) {
      position.add(direction.normalized() * speed * dt);
      animation = movingAnimation;
    } else {
      animation = idleAnimation;
    }
    isMoving = false; // Reset movement flag after processing
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    direction = Vector2.zero();
    isMoving = keysPressed.isNotEmpty; // Player is moving if any key is pressed

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      direction += Vector2(0, -1);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      direction += Vector2(0, 1);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      direction += Vector2(-1, 0);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      direction += Vector2(1, 0);
    }

    return super.onKeyEvent(event, keysPressed);
  }

  /// Loads and returns a [SpriteAnimation] for the player based on the provided [animationType].
  Future<SpriteAnimation> _loadAnimation(String animationType) async {
    // Placeholder for loading animations
    // In a real scenario, you would load the animation frames from assets
    return SpriteAnimation.empty();
  }

  /// Increments the player's score by the given [points].
  void addScore(int points) {
    score += points;
  }

  /// Decrements the player's lives by one.
  void loseLife() {
    lives--;
    if (lives <= 0) {
      // Handle game over state
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Handle collision with other game elements
  }
}