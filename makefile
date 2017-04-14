SHELL = /bin/bash

define require_installed
	if test "$(shell which $(1))" = ""; \
	then \
		brew install $(2); \
	else \
		echo $(1) is installed; \
	fi
endef

install:
	@$(call require_installed,ag,ag)
	@$(call require_installed,mpg123,mpg123)
	@$(call require_installed,offlineimap,offline-imap)
	@$(call require_installed,markdown,markdown)
	@$(call require_installed,python,python)
	@$(call require_installed,pip,pip)
	if test "$(shell pip show virtualenv)" = ""; pip install virtualenv; fi
