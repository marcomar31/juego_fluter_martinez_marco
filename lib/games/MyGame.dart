import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import '../elementos/Estrella.dart';
import '../elementos/Gota.dart';
import '../players/EmberPlayer.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents {
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

    ObjectGroup? estrellas=mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for(final estrella in estrellas!.objects) {
      Estrella spriteStar = Estrella(position: Vector2(estrella.x*1.5,estrella.y*1.45),
          size: Vector2(64, 64));
      add(spriteStar);
    }

    ObjectGroup? gotas=mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      Gota spriteGota = Gota(position: Vector2(gota.x*1.5,gota.y*1.45),
          size: Vector2(64,64));
      add(spriteGota);
    }
    _ember = EmberPlayer(
      position: Vector2(60, 360),
    );
    world.add(_ember);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }
}
