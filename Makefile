# Yuxuan Zhang, github@z-yx.cc
HOME_TARGETS:=$(shell ls -A home)

${HOME}/%: home/%
	@lib/symlink $< $@

install: $(foreach el,${HOME_TARGETS},${HOME}/${el})
	@echo "Restart your shell to apply changes."

.PHONY: install ${HOME}/%
