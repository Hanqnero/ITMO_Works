#import "template/math-macros.typ": *

= Задание 1

Дана система с задержкой

$
  &dot(x) = - sign x (t-h)
  ,quad t >= 0,quad h=2
  \
  &x(t) = phi(t),quad t in [-2, 0]
  \
  &phi(t) = (t+1)^2-1 = t^2+2t
$

== Решение

=== Интервал $t in [0, 2]$

Здесь 

$
  dot(x) = - sign phi (t-2)
$

Для $t in [0,2]: t-2 in [-2: 0]$

$
  phi(t-2) = (t-1)^2-1 = t^2-2t
$

Знаки
$
  cases(
    phi(t-2) > 0 quad t in.not [0,2],
    phi(t-2) = 0 quad t in {0,2},
    phi(t-2) < 0 quad t in [0,2]
  )
$

Следовательно
$
  sign phi(t-2) = -1, t in (0,2) \
  dot(x)(t) = 1, quad t in (0,2)
$

Начальное условие 
$
  x(0) = phi(0) = (0+1)^2 - 1 = 0
$

Интегрирование

#let int0t = $integral_0^t$

$
  int0t dif x  = int0t dif s => x(t) = t,quad t in [0,2]
$

В частоности

$
  x(2) = 2
$

=== Шаг 2. Интервал $t in [2,4]$

Теперь

$
  dot(x)(t) = - sign x (t-2)
$

Для $t in [2,4]: t-2 in [0,2]$

$
  x (t-2) = t-2 > 0,quad t in (2,4]
$

Следовательно

$
  sign x (t-2) = 1
  ,quad dot(x)(t) = -1 ,quad t in (2,4]
$

Начальное условие

$
  x(2)=2
$

Интегрирование

#let int2t = $integral_2^t$

$
  int2t dif x = - int2t dif s => x(t) -t + 4
  ,quad t in [2,4]
$

Итоговое Решение

$
  x(t) = cases(
    (t+1)^2-1 quad & t in[-2, 0],
    t & t in [-0,2],
    -t+4 & t in [2,4]
  )
$
=== График

График строится как
- парабола на $[0,2]$
- возрастающая прямая $[0,2]$
- убыващая прямая на $[2,4]$

#figure(
  image("img/task1.png"),
  caption: [Выход системы]
)