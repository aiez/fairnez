# vim: ts=2 sw=2 sts=2 et :
KONFIG ?= ../konfig
APP    := fairnez
PKG    := python3 gawk neovim tmux

$(KONFIG)/Makefile:
	@test -f $@ || { echo "missing konfig: git clone http://tiny.cc/konfig $(KONFIG)"; exit 1; }
include $(KONFIG)/Makefile

## propose ----------------------------------------------------

propose: ## scan CSVs, write proposals.txt of protected candidates
	@python3 protect.py propose

## apply ------------------------------------------------------

apply: ## read proposals.txt, add '~' suffix to approved cols (idempotent)
	@python3 protect.py apply

## protect ----------------------------------------------------

protect: ## propose then open proposals.txt for editing
	@python3 protect.py propose
	@printf '\nedit %s/proposals.txt to approve/reject, then: make apply\n' "$(CURDIR)"
