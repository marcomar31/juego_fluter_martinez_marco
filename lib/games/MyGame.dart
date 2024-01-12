import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../configs/config.dart';
import '../players/EmberPlayer.dart';

class MyGame extends FlameGame {
  MyGame()
      : super(
          camera: CameraComponent.withFixedResolution(
          width: 16 * 28,
          height: 16 * 14,
          ),
      );

  late EmberPlayer _ember;
  late TiledComponent mapComponent;

  @override
  Future<void> onLoad() async {
    camera.viewfinder
      ..zoom = 0.35
      ..anchor = Anchor.topLeft;

    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'nature-platformer-tileset-16x16.png',
    ]);

    mapComponent = await TiledComponent.load('mapa2.tmx', Vector2.all(16));
    world.add(mapComponent);

    _ember = EmberPlayer(
      position: Vector2(60, 360),
    );
    world.add(_ember);
  }
}
