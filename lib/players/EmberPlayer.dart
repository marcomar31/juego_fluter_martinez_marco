import 'dart:async';

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juego_flutter_martinez_marco/games/MyGame.dart';
import 'package:flame_forge2d/body_component.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<MyGame>, KeyboardHandler {
  int horizontalDirection = 0;
  int verticalDirection = 0;
  late int iTipo = -1;
  bool jugadorPrincipal;

  EmberPlayer({
    required super.position, required this.iTipo, required Vector2 size, this.jugadorPrincipal = true
  }) : super(size: Vector2.all(48), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    verticalDirection = 0;

    if (jugadorPrincipal) {
      if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
        horizontalDirection += 1;
        scale.x = 1;
      }

      if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
        horizontalDirection -= 1;
        scale.x = -1;
      }

      if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
        verticalDirection -= 1;
      }

      if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
        verticalDirection += 1;
      }
    }
    else {
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        horizontalDirection += 1;
        scale.x = 1;
      }

      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        horizontalDirection -= 1;
        scale.x = -1;
      }

      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        verticalDirection -= 1;
      }

      if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        verticalDirection += 1;
      }
    }

    return true;
  }
}

class EmberPlayerBody extends BodyComponent with KeyboardHandler, ContactCallbacks {
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 200;
  final Set<LogicalKeyboardKey> magiaSubZero={LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.keyA};
  final Set<LogicalKeyboardKey> magiaScorpio={LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.keyK};
  late int iTipo=-1;
  late Vector2 tamano;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  static const  int I_PLAYER_SUBZERO=0;
  static const  int I_PLAYER_SCORPIO=1;
  static const  int I_PLAYER_TANYA=2;
  late EmberPlayer emberPlayer;
  late double jumpSpeed=0.0;
  Vector2 initialPosition;
  bool blEspacioLiberado=true;
  int iVidas=3;
  bool jugadorPrincipal;

  EmberPlayerBody({required this.initialPosition,required this.iTipo,
    required this.tamano, this.jugadorPrincipal = true})
      : super();

  @override
  Body createBody() {
    BodyDef definicionCuerpo= BodyDef(position: initialPosition,
        type: BodyType.dynamic,angularDamping: 0.8,userData: this);

    Body cuerpo= world.createBody(definicionCuerpo);


    final shape=CircleShape();
    shape.radius=tamano.x/2;

    FixtureDef fixtureDef=FixtureDef(
        shape,
        friction: 0.2,
        restitution: 0.5, userData: this
    );
    cuerpo.createFixture(fixtureDef);

    return cuerpo;
  }

  @override
  Future<void> onLoad() {
    emberPlayer = EmberPlayer(position: Vector2(0,0),iTipo: iTipo, size: tamano);
    add(emberPlayer);
    return super.onLoad();
  }

  void onTapDown(_) {
    body.applyLinearImpulse(Vector2.random() * 5000);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final bool isKeyDown = event is RawKeyDownEvent;
    final bool isKeyUp = event is RawKeyUpEvent;

    if (jugadorPrincipal) {
      if(isKeyDown){
        horizontalDirection = 0;
        verticalDirection = 0;

        if(keysPressed.contains(LogicalKeyboardKey.keyA)){
          horizontalDirection=-1;
        }
        else if(keysPressed.contains(LogicalKeyboardKey.keyD)){
          horizontalDirection=1;
        }


        if(keysPressed.contains(LogicalKeyboardKey.keyW)){
          verticalDirection=-1;
        }
        else if(keysPressed.contains(LogicalKeyboardKey.keyS)){
          verticalDirection=1;
        }

        if(keysPressed.contains(LogicalKeyboardKey.space)){
          if(blEspacioLiberado)jumpSpeed=2000;
          blEspacioLiberado=false;
        }
      }
      else if(isKeyUp){
        blEspacioLiberado=true;
      }
      return true;
    }

    else {
      if(isKeyDown){
        horizontalDirection = 0;
        verticalDirection = 0;

        if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
          horizontalDirection=-1;
        }
        else if(keysPressed.contains(LogicalKeyboardKey.arrowRight)){
          horizontalDirection=1;
        }


        if(keysPressed.contains(LogicalKeyboardKey.arrowUp)){
          verticalDirection=-1;
        }
        else if(keysPressed.contains(LogicalKeyboardKey.arrowDown)){
          verticalDirection=1;
        }

        if(keysPressed.contains(LogicalKeyboardKey.space)){
          if(blEspacioLiberado)jumpSpeed=2000;
          blEspacioLiberado=false;
        }
      }
      else if(isKeyUp){
        blEspacioLiberado=true;
      }
      return true;
    }
  }

  @override
  void update(double dt) {
    velocidad.x = horizontalDirection * aceleracion;
    velocidad.y = verticalDirection * aceleracion;
    velocidad.y += -1 * jumpSpeed;
    jumpSpeed=0;

    body.applyLinearImpulse(velocidad*dt*1000);

    if (horizontalDirection < 0 && emberPlayer.scale.x > 0) {
      emberPlayer.flipHorizontallyAroundCenter();
    } else if (horizontalDirection > 0 && emberPlayer.scale.x < 0) {
      emberPlayer.flipHorizontallyAroundCenter();
    }

    super.update(dt);
  }
}