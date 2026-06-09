# =====================================================================
#  Karolinska Institutet — ggplot2 theme + colour palette
#  Part of the portable `quarto-theme-ki/` folder.
#  Use from a project root with:  source("quarto-theme-ki/ki.R")
# =====================================================================

ki_color_palette_labelled <- c("Mörk plommon" = "#4F0433",
                      "Orange" = "#FF876F",
                      "Ljusorange" = "#FEEEEB",
                      "Ljusblå" = "#EDF4F4",
                      "Plommon (logotypfärg)" = "#870052",
                      "Mörk orange" = "#B84145",
                      "Mörkblå" = "#002C34",
                      "Blå" = "#4DB5BC")

ki_color_palette <- c("#4F0433",
                      "#FF876F",
                      "#870052",
                      "#B84145",
                      "#002C34",
                      "#4DB5BC",
                      "#FEEEEB",
                      "#EDF4F4")

# DM Sans ------------------------------------------------------------------
library(showtext)
## Prefer local TTFs (offline, reproducible). Drop the DM Sans files into
## quarto-theme-ki/fonts/DM_Sans/ to use them; otherwise fall back to the
## Google Fonts web copy automatically.
.ki_font_dir <- "quarto-theme-ki/fonts/DM_Sans"
if (file.exists(file.path(.ki_font_dir, "DMSans-Regular.ttf"))) {
  font_add("DM Sans",
           regular = file.path(.ki_font_dir, "DMSans-Regular.ttf"),
           bold    = file.path(.ki_font_dir, "DMSans-Bold.ttf"),
           italic  = file.path(.ki_font_dir, "DMSans-Italic.ttf"))
} else {
  font_add_google("DM Sans")
}
## Automatically use showtext to render text
showtext_auto()
showtext_opts(dpi = 300)

theme_ki <- function(fontfamily = "DM Sans", axisSize = 13, titleSize = 15, subtitleSize = 12,
                       margins = 12, axisFace = "plain", stripSize = 11,
                       panelDist = 0.6, legendSize = 11, legendTsize = 11) {
  theme_minimal() +
    theme(
      text = element_text(family = fontfamily),
      plot.title = element_text(
        family = fontfamily,
        size = titleSize,
      ),
      plot.subtitle = element_text(
        family = fontfamily,
        size = subtitleSize,
        face = "bold"
      ),
      axis.title.x = element_text(
        margin = margin(t = margins),
        size = axisSize
      ),
      axis.title.y = element_text(
        margin = margin(r = margins),
        size = axisSize
      ),
      axis.title = element_text(
        face = axisFace
      ),
      plot.caption = element_text(
        face = "italic"
      ),
      legend.text = element_text(family = fontfamily,
                                 size = legendSize),
      legend.title = element_text(family = fontfamily,
                                  size = legendTsize),
      strip.text = element_text(size = stripSize),
      legend.background = element_rect(color = "lightgrey"),
      strip.background = element_rect(color = "lightgrey"),
      panel.spacing = unit(panelDist, "cm", data = NULL),
      panel.border = element_rect(color = "grey", fill = NA)
    )
}

### Add this line to a ggplot to get KI color and fill:
# + scale_color_manual(aesthetics = c("fill","color"), values = ki_color_palette)

### These rows are optional for changing fonts for geom_text() and geom_text_repel(),
### etc, to match font family if needed.
### add to ggplot object with "+"
# update_geom_defaults("text", list(family = fontfamily)) +
# update_geom_defaults("text_repel", list(family = fontfamily)) +
# update_geom_defaults("textpath", list(family = fontfamily)) +
# update_geom_defaults("texthline", list(family = fontfamily))
