# You can put build options or custom tasks here
-include config.mk

THEME_NAME ?= my_theme
THEME_DIR = wp-content/themes/$(THEME_NAME)

CSS = $(wildcard src/css/*.css)
JS  = $(wildcard src/js/*.js)
PHP = $(wildcard src/php/*.php)
SVG = $(wildcard src/svg/*.svg)
SRC = $(CSS) $(JS) $(PHP) $(SVG)

PATH := node_modules/.bin:$(PATH)
MKDIR = @mkdir -p $(dir $@)

all: css js php svg

css: $(THEME_DIR)/style.css

$(THEME_DIR)/style.css: $(addsuffix .out, $(CSS))
	$(MKDIR)
	cat src/css/theme $^ > $@

%.css.out: %.css
	$(MKDIR)
	postcss $(POSTCSS_FLAGS) $< > $@

js: $(THEME_DIR)/bundle.js

$(THEME_DIR)/bundle.js: $(addsuffix .out, $(JS))
	$(MKDIR)
	cat $^ > $@

%.js.out: %.js
	$(MKDIR)
	node -c $^
	babel $(BABEL_FLAGS) $< > $@

php: $(patsubst src/php/%, $(THEME_DIR)/%, $(PHP))

$(THEME_DIR)/%.php: src/php/%.php
	$(MKDIR)
	php -l $^
	cp $< $@

svg: $(patsubst src/svg/%, $(THEME_DIR)/img/%, $(SVG))

$(THEME_DIR)/img/%.svg: src/svg/%.svg
	$(MKDIR)
	svgo $(SVGO_FLAGS) $< $@

# Automatically generate dependencies
include Sourcedeps
Sourcedeps: Makefile $(SRC)
	@echo -n > Sourcedeps
	@# Get @imported files from css
	@for f in src/css/*.css; do \
		echo $$f.out: $$f $$(grep -hoP '^@import "\K(.*)(?=")' $$f | sort | uniq | sed "s_^_src/css/_"); \
	done >> $@

clean:
	rm -rfv src/**/*.out $(THEME_DIR)

.PHONY: all clean css js php svg

