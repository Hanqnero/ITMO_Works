#import "template/math-macros.typ": *

= Задание 3. Критерий Попова

Рассмотрим нелинейную систему

$
  cases(
    dot(x) = A x + b xi ,
    sigma = c^top x ,
    xi = phi
  ) \

  A = mat(-3, 1; 1, -3) quad 
  b = mat(0;1) quad 
  c = mat(1;0) quad 
  phi(sigma)=sigma^5/5
$

== Решение 

По определению критерия Попова должно выполняться
$
  0 <= phi(sigma)/sigma <= mu_0, quad sigma != 0
$

Имеем

$
  phi(sigma)/sigma=sigma^5/(5sigma)=sigma^4/5 >= 0, quad forall sigma != 0
$

Верхняя граница:

$
  lim_(sigma -> oo) phi(sigma)/sigma = lim_(sigma -> oo) sigma^4/5 = +oo
$

Отсюда 

$
  mu_0 = +oo
$

и секторное условие выполнено.

=== 2. Устойчивость линейной части

Собственные значения матрицы $A$

$
  det(lambda I - A) = detmat(lambda+3, -1; -1, lambda+3) = 
  (lambda+3)^2 -1 = lambda^2 + 6 lambda + 8 ==>\
  ==> lambda_(1,2) = -3 plus.minus 1 = -2; -4 &
$

$Re(lambda_(1,2)) < 0$ отсюда матрица $A$ --- устойчива

=== 3. Проверка частотного условия Попова
Передаточная функция линейной части:
$
  W(lambda) = c^top (A - lambda I)^(-1) b
$
$
  A - lambda I = mat(
    -3-lambda, 1;1,-3-lambda
  ) \

  (A - lambda I)^(-1) = 1/((lambda+3)^2-1)mat(
    -3-lambda, -1;-1,-3-lambda) = 

  1/(lambda^2+6lambda+8) mat(
    -3-lambda, -1;-1,-3-lambda)
$

Тогда 

$
  W(lambda) = mat(1, 0) 1/(lambda^2+6lambda+8) mat(
    -3-lambda, -1;-1,-3-lambda) mat(0;1) = -1/(lambda^2+6lambda+8)
$

Переходим к частотной оси $lambda= j omega$

Так как $mu_0 = +oo$, условие Попова принимает вид

$
  Re[(1+j nu omega) W(j omega)] > 0,quad forall omega >= 0
$
где $nu > 0$.

Подставим

$
  W(j omega) = -1/(-omega^2+6j omega + 8)
$

Тогда 
$
  (1+j nu omega)W(j omega) = -(1+j nu omega)/(-omega^2+6j omega+8)
$

Домножим на комлексно-сопряженное число знаменателя и выделим 
вещественную часть

$
  Re[(1+j nu omega) W(j omega)] = ((omega^2-8)+6nu omega^2)/((omega^2-8)+36omega^2)
$

при $nu > 0$ числитель и знаменатель положительны для всех $omega > 0$,
следовательно 

$
  Re[(1+j nu omega) W(j omega)] > 0
$

и частотное условие выполнено.

Следовательно нелинейная система *асимптотически устойчива*.