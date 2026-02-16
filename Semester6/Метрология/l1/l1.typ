#import "template/gost-itmo.typ": gost-itmo
#import "template/titlepage.typ": gost-titlepage
#import "template/math-macros.typ": eqnn
#import "@preview/oxifmt:1.0.0": strfmt

#show: gost-itmo

#gost-titlepage(
  title: "Лабораторная работа №1",
  topic: "Метрология и основы стандартизации",

  authors: (
    "Смирнов А.В.",
    "Лебедева В.В.",
    "Холухина Д.Е."
  )
)

#let data = (1.90, 1.90, 2.00, 2.00, 1.90)

#let measurements-visual = data.map(
    x => $#strfmt("{:.2}", x)$
).enumerate(start: 1).flatten().map(
  x => if type(x) == content {x} else {str(x)}
)

#let results-visual = data.map(
    x => $#strfmt("{:.2}", x) plus.minus 0.08$
).enumerate(start: 1).flatten().map(x => if type(x) == content {x} else {str(x)})

#let results-table = table(columns: (1cm, 3cm),
  "№", $l, "мм"$,
  ..results-visual.flatten()
)
#let result_fig = figure(
  results-table,
  caption: figure.caption(position: top, [Прямые измерения величины $l$ с учетом погрешности])
)


#outline()
#pagebreak()

= Прямые измерения величины

#figure(
  table(columns: 2,
  sym.numero, $l, "мм"$,
  ..measurements-visual
  ),
  caption: figure.caption(position: top)[Прямые измерения величины $l$]
)

= Обработка результатов измерения
== Среднее значение

По формуле
$
  overline(x) = 1/n sum_i^n x_i
$ <e1>

Результат 

#let data-avg = data.sum()/data.len()
#eqnn[
$
  overline(x) = strfmt("{:.3}", #data-avg)
$]

== Среднеквадратическое отклонение S группы

По формуле
$
  S_x = sqrt(1/(n-1) sum_(i=1)^n (x_i-overline(x) )^2 )
$

Результат

#let data-ms = calc.sqrt(data.map(x => (x - data-avg)*(x - data-avg)).sum()/4)
 
#eqnn[$
S_x = strfmt("{:.4}", #data-ms)
$]

== Среднеквадратическое отклонение среднего арифметического
По формуле
$
  S_overline(x) = S/sqrt(n)
$

#let data-msa = data-ms/calc.sqrt(5)
Результат

#eqnn[$
  S_overline(x) = strfmt("{:.4}", #data-msa)
$]

== Искючение грубых погрешностей

По формуле
$
  G_1 = abs(x_"max" - overline(x))/S, quad
  G_2 = abs(overline(x)-x_"min")/S
$

#let data-max = data.reduce(calc.max)
#let data-min = data.reduce(calc.min)

#let G1 = calc.abs(data-max - data-avg)/data-ms
#let G2 = calc.abs(data-avg - data-min)/data-ms

Результат
#eqnn[$
  G_1 = strfmt("{:.3}", G1), quad
  G_2 = strfmt("{:.3}", G2)
$]

Сравним с теоритическими значениями критерия Граббса

Для $n=5$: $G_T = 1.715$

Так как 
#eqnn[$ G_2 < G_1 < G_T $]
не считаем $x_min$ и $x_max$ промахами.

== Доверительные границы случайной погрешности

По формуле
$
  epsilon = t S_overline(x)
$
где $t$ --- коэффициент Стьюдента (выбран для $P=0.95$)


#let data-epsilon = 2.776*data-msa
Результат
#eqnn[$
  t = 2.776 quad
  epsilon = strfmt("{:.4}", #data-epsilon)
$]

== Учет систематической погрешности

По формуле
$ 
  theta = Delta/2
$

#let data-theta = 0.05
Результат
#eqnn[$
  Delta = 0.1 quad 
  theta = 0.0500
$]

== Учет полной погрешности прямого измерения
По формуле
$
  Delta overline(x) = sqrt(epsilon^2+theta^2)
$ <e7>

#let abs-error = calc.sqrt(
  data-epsilon*data-epsilon + data-theta*data-theta

)
Результат
#eqnn[$Delta overline(x) = strfmt("{:.4}", #abs-error) approx
 strfmt("{:.2}", #abs-error) 
$]

Относительная погрешность

#eqnn[$
  delta x = (Delta overline(x))/overline(x) dot 100% = strfmt("{:.2}", #{abs-error/data-avg*100} )%
$]

#result_fig


= Приложение

#figure(
  image("img/1.pdf", height: 90%),
  caption: [Протокол измерений лабораторной работы]
)

= Выводы

В лабораторной работе выполнили оценку погрешности на основании
проведения прямых измерений. В процессе выполнения работы познакомились
с правилами округления и записи результатов измерений; с понятием значящих
цифр. Выполнили обработку результатов прямых измерений по формулам (@e1 --- @e7), найдя абсолютную полную погрешность. 