import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/painting.dart';

/// The Player component for the puzzle game.
class Player extends SpriteAnimationComponent with HasHitboxes, Collidable {
  /// The player's current health.
  double health = 100.0;

  /// The maximum health the player can have.
  final double maxHealth = 100.0;

  /// The duration of the player's invulnerability frames after taking damage.
  final double invulnerabilityDuration = 1.0;

  /// The timer for the player's invulnerability frames.
  double _invulnerabilityTimer = 0.0;

  /// Whether the player is currently invulnerable.
  bool get isInvulnerable => _invulnerabilityTimer > 0.0;

  /// Creates a new instance of the Player component.
  Player({
    required Vector2 position,
    required SpriteAnimation idleAnimation,
    required SpriteAnimation walkAnimation,
    required SpriteAnimation hurtAnimation,
  }) : super(
          position: position,
          size: Vector2.all(32.0),
          animation: idleAnimation,
        ) {
    addHitbox(HitboxCircle(radius: 16.0));
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the invulnerability timer
    if (_invulnerabilityTimer > 0.0) {
      _invulnerabilityTimer -= dt;
    }
  }

  /// Moves the player in the specified direction.
  void move(Vector2 direction) {
    position += direction * 200.0 * dt;
    animation = walkAnimation;
  }

  /// Stops the player's movement.
  void stopMoving() {
    animation = idleAnimation;
  }

  /// Damages the player, reducing their health.
  /// If the player is not invulnerable, they take the full damage.
  /// Otherwise, the damage is reduced by a percentage.
  void takeDamage(double damage) {
    if (!isInvulnerable) {
      health -= damage;
      _invulnerabilityTimer = invulnerabilityDuration;
      animation = hurtAnimation;
    } else {
      health -= damage * 0.5;
    }
  }

  /// Heals the player, increasing their health up to the maximum.
  void heal(double amount) {
    health = (health + amount).clamp(0.0, maxHealth);
  }
}