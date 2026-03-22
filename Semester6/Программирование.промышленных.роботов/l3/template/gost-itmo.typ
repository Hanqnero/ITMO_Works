#let gost-itmo(content, textsize: 12pt) = {

  set page(
    paper: "a4", 
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm),
    numbering: "1"
  )
  set text(size: textsize, lang: "ru", font: ("Times New Roman", "Cambria"))

  set par(
    first-line-indent: (all: true, amount: 1.25cm),
    justify: true,
    spacing: 1.25cm
  ) 
  show outline: set par(leading: 1pt)

  show heading: set text(weight: "semibold", size: textsize)
  show heading.where(level: 1): set block(inset: (top: 1.5em, bottom: 1em))

  set math.equation(numbering: "(1)")
  show math.frac: math.display

  show figure.where(kind: image): set figure(supplement: "Рисунок")

  content
}
