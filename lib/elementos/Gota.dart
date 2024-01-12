import 'package:flame/components.dart';
import 'package:juego_flutter_martinez_marco/games/MyGame.dart';

class Gota extends SpriteAnimationComponent with HasGameRef<MyGame>{

  Gota({
    required super.position, required super.size
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async{
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        amountPerRow: 2,
        textureSize: Vector2(16,16),
        stepTime: 0.12,
      ),
    );

    return super.onLoad();
  }

}