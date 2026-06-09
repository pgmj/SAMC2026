library(ggplot2)
library(latex2exp)
library(easyRasch2)

data("phq9")
dat <- phq9
simres <- RMlocdepQ3Cutoff(dat[,1:9], iterations = 1000, n_cores = 12, verbose = T)

simres$results |>
  ggplot(aes(diff)) +
  geom_histogram(fill = "#870052", color = "white") + # "#4DB5BC"
  theme_minimal(base_family = "DM Sans") +
  labs(title = TeX("Histogram of simulated $Q_3$ max-mean differences"),
       x = TeX("$Q_3$ residuals max-mean"),
       y = "Count") +
  ggplot2::theme(
    axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 12)),
    axis.title.y = ggplot2::element_text(margin = ggplot2::margin(r = 12))
  ) +
  geom_vline(xintercept = 0.16, linetype = 2, linewidth = 1.6, color = "#002C34") +
  annotate("text", angle = 90, y = 72, x = 0.155, label = "99th percentile cutoff") +
  scale_x_continuous(limits = c(0,NA))

ggsave(filename = "/Users/magnus.johansson.3/q3hist.png", dpi = 300)
# col = "#4DB5BC", main = "Histogram of simulated max-mean differences", xlab = "Q3 residuals max-mean")

RMlocdepQ3(data = dat[,1:9], cutoff = simres$p99)

library(easyRaschBayes)

dl <- dat[,1:9] %>%
  mutate(across(everything(), ~ .x + 1)) %>%
  rownames_to_column("id") %>%
  pivot_longer(!id,
               names_to = "item",
               values_to = "response")

prior_pcm <- prior(normal(0, 3), class = "Intercept") +
  prior(normal(0, 3), class = "sd", group = "id")

fit <- brm(
  response | thres(gr = item) ~ 1 + (1 | id),
  data   = dl,
  family = acat("logit"),
  prior = prior_pcm,
  chains = 4,
  cores  = 4,
  iter   = 4000,
  warmup = 1500,
  save_pars = save_pars(all = TRUE)
)
options(mc.cores = 8)
q3fit <- q3_statistic(fit)
q3post <- q3_post(q3fit, n_pairs = 10)
q3post$plot

ggsave(filename = "/Users/magnus.johansson.3/q3bayes.png", dpi = 300)

new_prior <- posterior_to_prior(fit)

new_fit <- update(fit, prior = new_prior)
