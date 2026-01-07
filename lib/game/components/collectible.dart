import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';

/// A component representing a collectible item in the game.
/// It includes features such as collision detection, a score value,
/// optional animation (e.g., spinning, floating), and a sound effect upon collection.
class Collectible extends SpriteComponent with Hitbox, Collidable {
  /// The score value this collectible adds upon being collected.
  final int scoreValue;

  /// The path to the sound effect file that should be played when the collectible is collected.
  final String collectionSoundPath;

  /// Indicates whether the collectible has been collected to prevent multiple collections.
  bool _collected = false;

  /// Creates a new instance of a collectible item.
  /// [scoreValue] specifies the score value of the collectible.
  /// [collectionSoundPath] specifies the path to the sound effect to play upon collection.
  /// [size] specifies the size of the collectible.
  /// [position] specifies the position of the collectible.
  /// [spritePath] specifies the path to the sprite image for the collectible.
  Collectible({
    required this.scoreValue,
    required this.collectionSoundPath,
    required Vector2 size,
    required Vector2 position,
    required String spritePath,
  }) : super(size: size, position: position) {
    this.sprite = Sprite.load(spritePath);
    addShape(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    // Load and set the sprite for the collectible.
    sprite = await Sprite.load(spritePath);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (!_collected) {
      _collected = true;
      // Play the collection sound effect.
      FlameAudio.play(collectionSoundPath);
      // Here you would typically add logic to increase the player's score.
      // For example: gameRef.player.score += scoreValue;
      // Then remove the collectible from the game.
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Optional: Add any animations or effects for the collectible here.
    // For example, you could make it spin or float up and down.
  }
}