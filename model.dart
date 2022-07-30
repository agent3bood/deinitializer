typedef DeInit = Function;

abstract class Model {
  int initCount = 0;
  final deInitializers = <DeInit>[];

  /// init() returns object de initializer function.
  DeInit init() {
    print('init $runtimeType: $initCount -> ${initCount + 1}');
    initCount++;
    deInitializers.add(_deInit);
    return () {
      for (final f in [...deInitializers]) {
        if (deInitializers.contains(f)) {
          deInitializers.remove(f);
          f.call();
        }
      }
    };
  }

  _deInit() {
    print('deInit $runtimeType: $initCount -> ${initCount - 1}');
    initCount--;
    // if (initCount == 0) {
    //   deInitializers.forEach((f) {
    //     f.call();
    //   });
    //   deInitializers.clear();
    // }
    if (initCount < 0) {
      throw Exception('deInit called moe than init() on $runtimeType');
    }
  }

  A getA() {
    final a = A();
    deInitializers.add(a.init());
    return a;
  }

  B getB() {
    final b = B();
    deInitializers.add(b.init());
    return b;
  }

  C getC() {
    final c = C();
    deInitializers.add(c.init());
    return c;
  }

  D getD() {
    final d = D();
    deInitializers.add(d.init());
    return d;
  }
}

class A extends Model {
  static A? i;
  A._();
  factory A() {
    if (i == null) {
      i = A._();
    }
    return i!;
  }
}

class B extends Model {
  static B? i;
  B._();
  factory B() {
    if (i == null) {
      i = B._();
    }
    return i!;
  }
}

class C extends Model {
  static C? i;
  C._();
  factory C() {
    if (i == null) {
      i = C._();
    }
    return i!;
  }
}

class D extends Model {
  static D? i;
  D._();
  factory D() {
    if (i == null) {
      i = D._();
    }
    return i!;
  }
}
