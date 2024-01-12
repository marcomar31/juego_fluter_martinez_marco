import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';

class SueloBody extends BodyComponent with ContactCallbacks {
  TiledObject tiledBody;
  Vector2 scales = Vector2(1, 1);

  SueloBody({required this.tiledBody, required this.scales});

  @override
  Future<void> onLoad() {
    renderBody = true;
    return super.onLoad();
  }

  @override
  Body createBody() {
    late FixtureDef fixtureDef;

    if (tiledBody.isRectangle) {
      PolygonShape shape = PolygonShape();

      final vertices = [
        Vector2(0, 0),
        Vector2(tiledBody.width * scales.x, 0),
        Vector2(tiledBody.width * scales.x, tiledBody.height * scales.y),
        Vector2(0, tiledBody.height * scales.y),
      ];

      shape.set(vertices);
      fixtureDef = FixtureDef(shape);
    } else if (tiledBody.isPolygon) {
      ChainShape shape = ChainShape();

      for (final point in tiledBody.polygon) {
        shape.vertices.add(Vector2(point.x * scales.x, point.y * scales.y));
      }
      Point point0 = tiledBody.polygon[0];
      shape.vertices.add(Vector2(point0.x * scales.x, point0.y * scales.y));

      fixtureDef = FixtureDef(shape);
    }

    BodyDef definicionCuerpo =
    BodyDef(position: Vector2(tiledBody.x * scales.x, tiledBody.y * scales.y), type: BodyType.static);
    Body cuerpo = world.createBody(definicionCuerpo);

    fixtureDef.userData = this;

    cuerpo.createFixture(fixtureDef);
    return cuerpo;
  }
}
