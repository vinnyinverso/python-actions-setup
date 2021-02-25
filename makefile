.PHONY: clean build publish test develop

VERSION ?= $(shell git describe --tags | sed 's/-/\+/' | sed 's/-/\./g')
REPO_USER ?= unset
REPO_PASS ?= unset

build: clean
	sed -i.bak "s/__version__ .*/__version__ = \"$(VERSION)\"/" harmony/__init__.py && rm harmony/__init__.py.bak
	python -m pip install --upgrade --quiet setuptools wheel twine
	python setup.py --quiet sdist bdist_wheel

publish: build
	python -m twine check dist/*
	python -m twine upload --username "$(REPO_USER)" --password "$(REPO_PASS)" dist/*

clean:
	rm -rf build dist *.egg-info || true

develop:
	echo "Install dependencies"

lint:
	echo "Lint"
	flake8 harmony

test:
	echo "Test"

cve-check:
	echo "Check CVEs"

