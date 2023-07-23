//
//  QRCodeGenerator.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

struct QRCodeGenerator {
    static func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 4, y: 4)
        if let qrCodeImage = filter.outputImage?.transformed(by: transform) {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }

        return UIImage()
    }
}
