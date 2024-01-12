import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import '../elementos/Estrella.dart';
import '../elementos/Gota.dart';
import '../players/EmberPlayer.dart';

class MyGame extends Forge2DGame with HasKeyboardHandlerComponents {
  MyGame()
      : super(
          cameraComponent: CameraComponent.withFixedResolution(
          width: 16 * 28,
          height: 16 * 14,
          ),
      );

  late EmberPlayerBody  _ember1, _ember2;
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
      Estrella spriteStar = Estrella(position: Vector2(estrella.x*1.5, estrella.y*1.45),
          size: Vector2(64, 64));
      add(spriteStar);
    }

    ObjectGroup? gotas=mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      Gota spriteGota = Gota(position: Vector2(gota.x*1.5, gota.y*1.45),
          size: Vector2(64,64));
      add(spriteGota);
    }
    _ember1 = EmberPlayerBody(initialPosition: Vector2(168, canvasSize.y - 350),
        iTipo: EmberPlayerBody.I_PLAYER_TANYA, tamano: Vector2(50,100)
    );

    add(_ember1);

    _ember2 = EmberPlayerBody(initialPosition: Vector2(128, canvasSize.y - 350),
        iTipo: EmberPlayerBody.I_PLAYER_TANYA, tamano: Vector2(50,100), jugadorPrincipal: false
    );

    add(_ember2);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }
}
