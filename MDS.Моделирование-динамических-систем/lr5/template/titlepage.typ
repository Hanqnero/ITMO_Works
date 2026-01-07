#import "gost-itmo.typ": gost-itmo

#let signline(length: 4cm, undertext: [подпись, дата]) = {
  context{
    box(width: length, baseline: 100%,
        stack(dir: ttb, spacing: 0.5em,
          line(length: length, stroke: 1pt*50%),
          if (length >= measure(text(size: 1em * 75%, undertext)).width) {
            align(center, text(size: 1em * 75%, undertext))},
        )
      )
  }
}

#let gost-titlepage(

  ministry: [Министерство образования и науки Российской Федерации],
  organization: [
    ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ
ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ
  ],
  university: [
«НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ УНИВЕРСИТЕТ
ИТМО» \ (УНИВЕРСИТЕТ ИТМО)],

  title: lorem(20),
  topic: lorem(20),

  authors: (
    "Смирнов А.В.",
    "Смирнов А.В.",
    "Смирнов А.В.",
  )

) = {

  set document(
    title: title,
    description: topic
  )

  set par(leading: 0.8em)
  set page(numbering: none)

  align(center)[
    #ministry \
    #organization \
    #university
  ]

  let titletext = text.with(size: 1em*125%)

  place(center+horizon, dy: -2cm)[
    #show text: titletext
    #box(stroke: 0pt, inset: 5pt)[
      ОТЧЕТ \ О НАУЧНО-ИССЛЕДОВАТЕЛЬСКОЙ РАБОТЕ \
      #title \
      #if (topic.len() > 0) [ по теме: \ #topic ]
    ]
  ]
  
  place(end+top, dy: 15cm, box(baseline: 100%)[
    #align(start)[Список исполнителей:] \
    #for (e) in authors [
      #e #h(1cm) #signline() \
    ]
  ])

  place(center+bottom)[
    Санкт-Петербург #datetime.today().year()
  ]
  pagebreak()
}

#show: gost-itmo

#gost-titlepage()