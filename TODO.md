- scale_x_percent_cz
- scale_y_percent_cz
- scale_y_space
- scale_y_space
- scale_x_percent from hrbrmstr
- scale_y_percent from hrbrmstr
- scale_x_space from hrbmstr
- scale_y_space from hrbmstr
- [ggcheck_cz wrapper around hrbrmstr]
- expansion_barchart

- figure out font import, see ratlas zzz.R

- theme_schola
- update_geom|text_font_defaults
- palettes
- colour scales
- [theme setter]
- font abbreviations
- colour abbreviations (brand colour)
- googledrive bridge

- [multishader] palette generator

- plot saving function

- project template

- custom make_draft functions

- utils: file finders, see ratlas

- template for docx + renderer using docx template file
- quick wrapper around giraffe - automatic tooltip (build_tooltip fn with vars on the input, then pass this through a girafe_auto fn or some such - but do the building of the tooltip column and the css automatically)>

dataframe %>% 
  feed_giraffe(variables for ID and tooltip) %>% # (= build tooltip and some other stuff - perhaps ID)
  ggplot(aes(xyz)) +
  geom_*_autointeractive() # automatically finds tooltip and ID column and styling [point, bar]
