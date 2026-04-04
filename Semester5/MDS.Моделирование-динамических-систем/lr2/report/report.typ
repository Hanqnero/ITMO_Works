#import "template/gost-itmo.typ": gost-itmo
#import "template/titlepage.typ": gost-titlepage

#show: gost-itmo

#gost-titlepage(
  title: "Лабораторная работа №2 (Вариант 7)",
  topic: "Моделирование динамических систем",
  authors: (
    "Смирнов А.В.",
    "Иванов Н.М.",
    "Сухов Н.М.",
    "Холухина Д.Е.",
  )
)

#outline()
#pagebreak()

#include "task1.typ"
#pagebreak()

#include "task2.typ"
#pagebreak()

#include "task3.typ"
// #pagebreak()

= Вывод

В работе определили устойчивость различных нелинейных систем, пользуясь разными способами и критериями. Были рассмотрены
- Линеаризация системы через якобиан
- Метод Ляпунова для асимптотической      устойчивости
- Круговой критерий
- Критерий Попова