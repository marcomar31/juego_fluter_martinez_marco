import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:juego_flutter_martinez_marco/games/MyGame.dart';

import '../elementos/Gota.dart';

class GotaBody extends BodyComponent<MyGame> with ContactCallbacks{
  Vector2 posicion;
  Vector2 escala;
  double xIni=0;
  double xFin=0;
  double xContador=0;
  double dAnimDireccion=-1;
  double dVelocidadAnim=1;
  double tamano;

  final double tamanoPred = 15.75;

  GotaBody({required this.posicion,required this.escala, required this.tamano}):super();

  @override
  Body createBody() {
    BodyDef bodyDef = BodyDef(type: BodyType.dynamic,position: posicion,gravityOverride: Vector2(0,0));
    Body cuerpo=world.createBody(bodyDef);
    CircleShape shape=CircleShape();
    shape.radius=escala.x/2;

    Fixture fix=cuerpo.createFixtureFromShape(shape);

    fix.userData=this;

    return cuerpo;
  }

  @override
  Future<void> onLoad() async{
    renderBody = false;
    await super.onLoad();

    Vector2 gotaPosition = Vector2(tamanoPred * tamano-12, 0);

    Gota gotaPlayer=Gota(position: gotaPosition, size: escala);
    add(gotaPlayer);

    xIni=posicion.x;
    xFin=(40);
    xContador=0;

  }

  @override
  void update(double dt) {
    super.update(dt);
  }


}