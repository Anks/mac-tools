import AppKit
import Foundation
import Vision

func inputImage() -> NSImage? {
    if CommandLine.arguments.count == 2 {
        let imagePath = CommandLine.arguments[1]
        let imageURL = URL(fileURLWithPath: imagePath)
        return NSImage(contentsOf: imageURL)
    } else {
        let pasteboard = NSPasteboard.general
        if let clipboardData = pasteboard.data(forType: .tiff),
           let clipboardImage = NSImage(data: clipboardData) {
            return clipboardImage
        }
    }
    return nil
}

guard let inputImage = inputImage() else {
    print("Usage: ./ocr [image-path]")
    print("If image-path is not provided, the script will attempt to use an image from the clipboard.")
    exit(1)
}

guard let cgImage = inputImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
    print("Error: Could not convert input image to CGImage.")
    exit(1)
}

let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])

let request = VNRecognizeTextRequest { (request, error) in
    if let error = error {
        print("Error: \(error.localizedDescription)")
        exit(1)
    }

    if let results = request.results as? [VNRecognizedTextObservation] {
        for result in results {
            if let topCandidate = result.topCandidates(1).first {
                print(topCandidate.string)
            }
        }
    }
    exit(0)
}

request.recognitionLevel = .accurate

do {
    try requestHandler.perform([request])
} catch {
    print("Error: \(error.localizedDescription)")
    exit(1)
}
