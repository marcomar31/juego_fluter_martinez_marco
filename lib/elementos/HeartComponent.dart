import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' as material;

class HeartComponent extends PositionComponent {
  late Image imageFullHeart;
  late List<Image> imagesFullHeart;
  int lives;
  double startX;
  double startY;
  String playerName;

  HeartComponent({
    required this.imageFullHeart,
    required this.lives,
    required this.startX,
    required this.startY,
    this.playerName = "",
  }) {
    imagesFullHeart = List.generate(lives, (index) => imageFullHeart);
  }

  @override
  void render(Canvas canvas) {
    double x = startX;
    double y = startY;

    for (int i = 0; i < lives; i++) {
      canvas.drawImage(
        imagesFullHeart[i],
        Offset(x, y),
        Paint(),
      );
      x += size.x + 35;
    }

    material.TextSpan span = material.TextSpan(
      text: playerName,
      style: const material.TextStyle(
        color: material.Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    material.TextPainter tp = material.TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    double textX = startX + (lives * (size.x + 35) / 2) - (tp.width / 2);
    tp.paint(canvas, Offset(textX, y - 20));
  }

  void loseLife() {
    if (lives > 0) {
      lives--;
    }
  }
}