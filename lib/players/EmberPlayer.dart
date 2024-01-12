import 'package:flame/components.dart';

import '../games/MyGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<MyGame> {
  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(48), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }
}