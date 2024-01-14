import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:juego_flutter_martinez_marco/bodies/SueloBody.dart';
import '../elementos/Estrella.dart';
import '../elementos/Gota.dart';
import '../elementos/HeartComponent.dart';
import '../players/EmberPlayer.dart';

class MyGame extends Forge2DGame with HasKeyboardHandlerComponents {
  MyGame()
      : super(
          cameraComponent: CameraComponent.withFixedResolution(
          width: 16 * 28,
          height: 16 * 14,
          ),
      );

  late EmberPlayerBody  _ember1;
  late EmberPlayerBody2  _ember2;
  late TiledComponent mapComponent;
  late HeartComponent heartComponent1;
  late HeartComponent2 heartComponent2;

  @override
  Future<void> onLoad() async {
    camera.viewfinder
      ..zoom = 0.35
      ..anchor = Anchor.topLeft;

    await images.loadAll([
      'ember.png',
      'ember1.png',
      'ember2.png',
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

    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      Gota spriteGota = Gota(position: Vector2(gota.x*1.5, gota.y*1.45),
          size: Vector2(64, 64));
      add(spriteGota);
    }

    ObjectGroup? suelos = mapComponent.tileMap.getLayer<ObjectGroup>("sueloCollider");

    for(final tiledObjectSuelo in suelos!.objects){
      SueloBody sueloBody = SueloBody(tiledBody: tiledObjectSuelo,
          scales: Vector2(1.50, 1.5));
      add(sueloBody);
    }

    //JUGADORES
    _ember1 = EmberPlayerBody(initialPosition: Vector2(148, canvasSize.y - 450),
        iTipo: EmberPlayerBody.I_PLAYER_TANYA, tamano: Vector2(50,50)
    );
    _ember1.onBeginContact = inicioContactosDelJuego;

    add(_ember1);

    _ember2 = EmberPlayerBody2(initialPosition: Vector2(68, canvasSize.y - 450),
        iTipo: EmberPlayerBody2.I_PLAYER_TANYA, tamano: Vector2(50,50)
    );
    //_ember2.onBeginContact = inicioContactosDelJuego;

    add(_ember2);

    heartComponent1 = HeartComponent(
      _ember1,
      50,
      100,
      "Jugador 1"
    );

    add(heartComponent1);

    heartComponent2 = HeartComponent2(
      _ember2,
      canvasSize.x - 150,
      100,
      "Jugador 2",
    );

    add(heartComponent2);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  void inicioContactosDelJuego(Object objeto, Contact contact) {
    if (objeto is EmberPlayerBody2) {
      print("ES CONTACTO DE EMBERBODY2");
      _ember1.iVidas--;
      if (_ember1.iVidas == 0) {
        _ember1.removeFromParent();
      }
    }
  }
}

