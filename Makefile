
PY  = bin/python
PIP = bin/pip


install: apt
	$(MAKE) $(PIP)

apt:
	sudo apt update
	sudo apt install -u `cat apt.txt apt.dev`

$(PY) $(PIP):
	python3 -m venv .
