import 'model.dart';

void main() {
  {
    print('A\n');
    final a = A();
    final deInitializer = a.init();
    deInitializer.call();

    assertZeroInitCount();
  }

  {
    print('A->A\n');
    final a = A();
    final deInitializer = a.init();
    a.getA();
    deInitializer.call();

    assertZeroInitCount();
  }

  {
    print('A->B\n');
    final a = A();
    final deInitializer = a.init();
    a.getB();
    deInitializer.call();

    assertZeroInitCount();
  }

  {
    print('A->B->A\n');
    final a = A();
    final deInitializer = a.init();
    final b = a.getB();
    b.getA();
    deInitializer.call();

    assertZeroInitCount();
  }

  {
    print('A->B,C,D\n');
    final a = A();
    final deInitializer = a.init();
    a.getB();
    a.getC();
    a.getD();
    deInitializer.call();

    assertZeroInitCount();
  }

  {
    print('A->B->C->D\n');
    final a = A();
    final deInitializer = a.init();
    final b = a.getB();
    final c = b.getC();
    final d = c.getD();
    deInitializer.call();

    assertZeroInitCount();
  }

  {
    print('A->B->C->D\nB->A');
    final a = A();
    final deInitializer = a.init();
    final b = a.getB();
    final c = b.getC();
    final d = c.getD();

    final b2 = B();

    final deInitializer2 = b2.init();

    deInitializer.call();
    deInitializer2.call();

    assertZeroInitCount();
  }

  {
    print('A->B->C->D\nA->B->C->D\n');
    final a = A();
    final deInitializer = a.init();
    final b = a.getB();
    final c = b.getC();
    final d = c.getD();

    final a2 = A();
    final deInitializer2 = a.init();
    final b2 = a2.getB();
    final c2 = b2.getC();
    final d2 = c2.getD();

    deInitializer.call();
    deInitializer2.call();

    assertZeroInitCount();
  }

  {
    print('A->(B->A,C->B)');
    final a = A();
    final deInitializerA = a.init();

    final b = a.getB();
    final a2 = b.getA();

    final c = a.getC();
    final b2 = c.getB();

    deInitializerA.call();

    assertZeroInitCount();
  }

  {
    print('A->(B,C->(B->A))');
    final a = A();
    final deInitializerA = a.init();

    final b = a.getB();
    final c = a.getC();

    final b2 = c.getB();
    final a2 = c.getA();

    deInitializerA.call();
  }
}

void assertZeroInitCount() {
  assert(A.i == null || A.i!.initCount == 0);
  print('~~~');
}
