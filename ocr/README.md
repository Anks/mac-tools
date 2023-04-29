# OCR

A CLI tool that uses the [Vision Framework][1] to detect text from images. Works only on Apple Silicon macs.

Usage:

```
# Prints detected text on stdout
$ ocr path-to-image.png
Detected text

# Tries to read image data from clipboard
$ ocr
Detected text from clipboard
```

[1]: https://developer.apple.com/documentation/vision/vnimagerequesthandler
