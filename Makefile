# var
MODULE = $(notdir $(CURDIR))

HOST = 127.0.0.1
PORT = 12345

# tool
CURL = curl -L -o
PY   = bin/python
PIP  = bin/pip

# django

all: runserver

runserver: $(PY) manage.py
	$^ $@ $(HOST):$(PORT)

makemigrations: $(PY) manage.py
	$^ $@

migrate: $(PY) manage.py
	$^ $@

dumpdata: $(PY) manage.py
	$^ $@ --indent 2 > tmp/$(MODULE).$@.json

FIXTURE = $(shell find fixture -type f -regex ".+.json$$")

loaddata: $(PY) manage.py
	$^ $@ $(FIXTURE)

createsuperuser: $(PY) manage.py
	$^ $@

# install

install: apt
	$(MAKE) $(PIP)
	$(MAKE) update
	$(MAKE) migrate loaddata

update: apt
	$(PIP) install -U    pytest autopep8
	$(PIP) install -U -r requirements.txt

apt:
	sudo apt update
	sudo apt install -u `cat apt.txt apt.dev`

$(PY) $(PIP):
	python3 -m venv .
	$(MAKE) update

# merge

MERGE  = Makefile README.md apt.txt apt.dev
MERGE += bin doc lib src tmp
MERGE += requirements.txt $(MODULE) fixture static index

dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout ponymuck -- $(MERGE)

ponymuck:
	git push -v
	git checkout $@
	git pull -v
