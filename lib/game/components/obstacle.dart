import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

/// A component representing an obstacle in the puzzle game.
/// It has a visual representation, can move or spawn at specific locations,
/// deals damage on collision, and has a collision hitbox.
class Obstacle extends PositionComponent with HasHitboxes, Collidable {
  final Vector2 _movement;
  final double _damage;
  final Paint _paint;
  late final RectangleHitbox _hitbox;

  /// Creates an instance of an obstacle.
  /// 
  /// [size] defines the size of the obstacle.
  /// [position] defines the initial position of the obstacle.
  /// [movement] defines the movement vector for the obstacle.
  /// [damage] defines the damage dealt by the obstacle on collision.
  /// [color] defines the color of the obstacle.
  Obstacle({
    required Vector2 size,
    required Vector2 position,
    required Vector2 movement,
    required double damage,
    required Color color,
  })  : _movement = movement,
        _damage = damage,
        _paint = Paint()..color = color,
        super(position: position, size: size) {
    _hitbox = RectangleHitbox();
    addHitbox(_hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(_movement * dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }

  /// Handles the logic when this obstacle collides with another [Collidable].
  /// 
  /// In this context, it could deal damage or trigger a specific game event.
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Example: Deal damage to the player or trigger an event.
  }
}