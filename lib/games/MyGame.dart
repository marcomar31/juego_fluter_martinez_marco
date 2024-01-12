import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../configs/config.dart';

class MyGame extends FlameGame {
  MyGame();

  late final CameraComponent cameraComponent;
  late TiledComponent mapComponent;

  double wScale = 1, hScale = 0.8842592592592593;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'nature-platformer-tileset-16x16.png',
    ]);
    cameraComponent = CameraComponent(world: world);

    wScale=size.x/gameWidth;
    hScale=size.y/gameHeight;

    print("RESOLUCION IDEAL: ${gameWidth} x ${gameHeight}");
    print("RESOLUCION MI PANTALLA: ${size.x} x ${size.y}");
    print("LA ESCALA SERIA: ${wScale} x ${hScale}");

    camera.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent = await TiledComponent.load('mapa2.tmx', Vector2(32 * wScale, 32 * hScale));

    world.add(mapComponent);
  }
}