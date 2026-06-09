# quarto-theme-ki

A portable Karolinska Institutet theme for Quarto reveal.js slides, plus a
matching ggplot2 theme. **Copy this whole folder into a project root** and
point a `.qmd` at it.

## Contents

```
quarto-theme-ki/
├── ki.scss              # reveal.js slide theme
├── ki.R                 # ggplot2 theme + KI colour palette
├── template.qmd         # starter deck — copy to project root and edit
├── assets/              # KI logos (neg = white, pos = black, rgb = colour)
└── fonts/DM_Sans/       # optional: drop DM Sans .ttf files here for offline use
```

## Quick start

1. Copy the whole `quarto-theme-ki/` folder into your project root.
2. Copy `quarto-theme-ki/template.qmd` to the project root, rename it, and edit.
3. Render. (The theme path `quarto-theme-ki/ki.scss` is relative to the root.)

## Use in slides

In your root `.qmd` front matter:

```yaml
format:
  revealjs:
    theme: [default, quarto-theme-ki/ki.scss]
    slide-number: true
    footer: "Karolinska Institutet – ett medicinskt universitet"
    title-slide-attributes:
      data-background-color: "#4F0433"
```

## Slide types

| Style | Markdown | Look |
|-------|----------|------|
| Title | from YAML `title`/`subtitle`/`author` | dark plum, white text, KI logo |
| Content | `## Heading` | white, plum heading, plum bullets |
| Pale section | `## Heading {.ljusbla}` | pale-blue background |
| Pale section | `## Heading {.ljusorange}` | pale-orange background |
| Divider | `## Heading {.plum}` | dark plum, white text |
| Divider | `## Heading {.blue}` | deep blue, white text |

## Use in plots (R)

```r
source("quarto-theme-ki/ki.R")
ggplot(...) +
  theme_ki() +
  scale_color_manual(aesthetics = c("fill", "color"), values = ki_color_palette)
```

`ki.R` uses local DM Sans TTFs from `fonts/DM_Sans/` if present, otherwise
falls back to the Google Fonts web copy.

## KI palette

`#4F0433` plum · `#870052` logo plum · `#FF876F` orange · `#B84145` dark
orange · `#FEEEEB` light orange · `#4DB5BC` blue · `#002C34` dark blue ·
`#EDF4F4` light blue.
