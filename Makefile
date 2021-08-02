
PY  = bin/python
PIP = bin/pip


install: apt
	$(MAKE) $(PIP)
	$(MAKE) update

update: apt
	$(PIP) install -U    pytest autopep8
	$(PIP) install -U -r requirements.txt

apt:
	sudo apt update
	sudo apt install -u `cat apt.txt apt.dev`

$(PY) $(PIP):
	python3 -m venv .
	$(MAKE) update

MERGE  = Makefile README.md apt.txt apt.dev
MERGE += bin doc lib src tmp
MERGE += requirements.txt

dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout ponymuck -- $(MERGE)

ponymuck:
	git push -v
	git checkout $@
	git pull -v
