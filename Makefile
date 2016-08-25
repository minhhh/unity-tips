## Helper

help: # show help
	@echo ""
	@grep "^##" $(MAKEFILE_LIST) | grep -v grep
	@echo ""
	@grep "^[0-9a-zA-Z\-]*: #" $(MAKEFILE_LIST) | grep -v grep
	@echo ""

u: # Update
	git add -u && git commit -m "update" && git push

r: # Refactor
	git add -u && git commit -m "refactor" && git push

