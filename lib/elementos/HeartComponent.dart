import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juego_flutter_martinez_marco/players/EmberPlayer.dart';

class HeartComponent extends PositionComponent {
  EmberPlayerBody emberbody1;
  double startX;
  double startY;
  String playerName;

  late final ui.Image imageFullHeart;
  late final ui.Image imageHalfHeart;

  HeartComponent(
      this.emberbody1,
      this.startX,
      this.startY,
      this.playerName,
      ) {
    loadImages();
  }

  Future<void> loadImages() async {
    imageFullHeart = await loadImage('assets/images/heart.png');
    imageHalfHeart = await loadImage('assets/images/heart_half.png');
  }

  Future<ui.Image> loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final ui.Codec codec = await ui.instantiateImageCodec(Uint8List.view(data.buffer));
    final ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void render(ui.Canvas canvas) {
    const heartSize = 32.0;

    for (int i = 0; i < emberbody1.iVidas; i++) {
      final double heartX = startX + i * (heartSize + 10);
      final double heartY = startY;

      final ui.Image heartImage = (i < emberbody1.iVidas) ? imageFullHeart : imageHalfHeart;
      canvas.drawImageRect(
        heartImage,
        Rect.fromPoints(const Offset(0, 0), Offset(heartImage.width.toDouble(), heartImage.height.toDouble())),
        Rect.fromPoints(Offset(heartX, heartY), Offset(heartX + heartSize, heartY + heartSize)),
        ui.Paint(),
      );
    }

    TextSpan span = TextSpan(
      text: playerName,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    double textX = startX + (emberbody1.iVidas * (35) / 2) - (tp.width / 2);
    tp.paint(canvas, Offset(textX, startY - 20));
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x = 0;
    this.y = 0;
  }
}

class HeartComponent2 extends PositionComponent {
  EmberPlayerBody2 emberbody2;
  double startX;
  double startY;
  String playerName;

  late final ui.Image imageFullHeart;
  late final ui.Image imageHalfHeart;

  HeartComponent2(
      this.emberbody2,
      this.startX,
      this.startY,
      this.playerName,
      ) {
    loadImages();
  }

  Future<void> loadImages() async {
    imageFullHeart = await loadImage('assets/images/heart.png');
    imageHalfHeart = await loadImage('assets/images/heart_half.png');
  }

  Future<ui.Image> loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final ui.Codec codec = await ui.instantiateImageCodec(Uint8List.view(data.buffer));
    final ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void render(ui.Canvas canvas) {
    const heartSize = 32.0;

    for (int i = 0; i < emberbody2.iVidas; i++) {
      final double heartX = startX + i * (heartSize + 10);
      final double heartY = startY;

      final ui.Image heartImage = (i < emberbody2.iVidas) ? imageFullHeart : imageHalfHeart;
      canvas.drawImageRect(
        heartImage,
        Rect.fromPoints(const Offset(0, 0), Offset(heartImage.width.toDouble(), heartImage.height.toDouble())),
        Rect.fromPoints(Offset(heartX, heartY), Offset(heartX + heartSize, heartY + heartSize)),
        ui.Paint(),
      );
    }

    TextSpan span = TextSpan(
      text: playerName,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    double textX = startX + (emberbody2.iVidas * (35) / 2) - (tp.width / 2);
    tp.paint(canvas, Offset(textX, startY - 20));
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x = 0;
    this.y = 0;
  }
}
