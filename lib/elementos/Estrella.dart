

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:juego_flutter_martinez_marco/games/MyGame.dart';

class Estrella extends SpriteComponent with HasGameRef<MyGame> {


  Estrella({required super.position,required super.size});

  @override
  Future<void> onLoad() async {
    sprite=Sprite(game.images.fromCache('star.png'));
    anchor=Anchor.center;
    add(RectangleHitbox()..collisionType = CollisionType.passive);

    return super.onLoad();
  }
}