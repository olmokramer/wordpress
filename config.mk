# You can put build options or custom tasks here
THEME_NAME    = my_theme
THEME_DIR     = wp-content/themes/$(THEME_NAME)
POSTCSS_FLAGS =
BABEL_FLAGS   =
SVGO_FLAGS    =

deploy: $(SRC)
	scp -r $(THEME_DIR) user@example.com:domains/example.com/wp-content/themes

