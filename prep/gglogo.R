hh <- ggplot(mpg, aes(x = cty / 10000.03, y = hwy / 1000, size = hwy/1000)) +
  geom_point(alpha = .3) +
  scale_x_percent_cz(accuracy = 0.01, trim = F) +
  scale_y_percent_cz() +
  scale_size(labels = label_percent_cz(accuracy = 1)) +
  theme_schola("scatter", legend.position = "bottom") +
  labs(caption = "Blah")


pp <- ggplot(mpg, aes(x = cty / 10000.03, y = hwy / (hwy-max(hwy)) / 10, size = hwy/1000)) +
  geom_point(alpha = .3) +
  scale_x_percent_cz(accuracy = 0.01, trim = F) +
  scale_y_continuous(labels = label_percent_cz_abs(accuracy = 1)) +
  scale_size(labels = label_percent_cz(accuracy = 1)) +
  theme_schola("scatter")

library(patchwork)

(hh / pp) + plot_layout(guides = 'collect')

library(png)

lgimg <- png::readPNG(reschola:::reschola_file("rstudio/templates/project/proj_fls/logos/logo_grey_transparent_nospace.png"))
lgimg

lggrob <- grid::rasterGrob(lgimg)

p3 <- ggplot(mapping = aes(x = 0:1, y = 1)) +
  theme_void() +
  annotation_custom(lggrob, xmin = .8, xmax = 1)
p3
hh + p3 +
  plot_layout(design = "111
                        111
                        ##2")

png(res = 300, width = 16, height = 10, units = "cm", pointsize = 9)
gridExtra::grid.arrange(hh, lggrob, heights = c(.95, .05))
dev.off()
