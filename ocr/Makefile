all: ocr

ocr: ocr.swift
	swiftc -O ocr.swift -o ocr

.PHONY: clean
clean:
	rm ocr

.PHONY: install
install: ocr
	ln -sf $(abspath ocr) ~/.local/bin/ocr
