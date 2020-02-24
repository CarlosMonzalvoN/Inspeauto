//
//  PDFCreator.swift
//  AutoInspector
//
//  Created by Cesar on 23/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import PDFKit

class PDFCreator: NSObject {
  let title: String
  let body: String
  let image: UIImage
  let modelCar: String
  
  init(title: String, body: String, image: UIImage, model: String) {
    self.title = title
    self.body = body
    self.image = image
    self.modelCar = model
  }
  
  func createPDF() -> Data {
    let pdfMetaData = [
      kCGPDFContextCreator: "Generador de PDF",
      kCGPDFContextAuthor: "Vargas Cesar para InspeAuto",
      kCGPDFContextTitle: title
    ]
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]

    let pageWidth = 8.5 * 72.0
    let pageHeight = 11 * 72.0
    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
    let data = renderer.pdfData { (context) in
     
      context.beginPage()
   
      let titleBottom = addTitle(pageRect: pageRect)
      let imageBottom = addImage(pageRect: pageRect, imageTop: titleBottom + 18.0)
      addBodyText(pageRect: pageRect, textTop: imageBottom + 18.0)
      
    }
    
    return data
  }
  
  func addTitle(pageRect: CGRect) -> CGFloat {

    let titleFont = UIFont.systemFont(ofSize: 28.0, weight: .bold)
    let titleAttributes: [NSAttributedString.Key: Any] =
      [NSAttributedString.Key.font: titleFont]
    let attributedTitle = NSAttributedString(string: title + " (" + modelCar + ")", attributes: titleAttributes)
    let titleStringSize = attributedTitle.size()
    let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
                                 y: 36, width: titleStringSize.width,
                                 height: titleStringSize.height)

    attributedTitle.draw(in: titleStringRect)
    return titleStringRect.origin.y + titleStringRect.size.height
  }

  func addBodyText(pageRect: CGRect, textTop: CGFloat) {
    let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping
    let textAttributes = [
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.font: textFont
    ]
    let attributedText = NSAttributedString(string:"RESUMEN DEL PROBLEMA PRESENTADO:  " + body, attributes: textAttributes)
    let textRect = CGRect(x: 10, y: textTop, width: pageRect.width - 20,
                          height: pageRect.height - textTop - pageRect.height / 5.0)
    attributedText.draw(in: textRect)
  }

  func addImage(pageRect: CGRect, imageTop: CGFloat) -> CGFloat {

    let maxHeight = pageRect.height * 0.4
    let maxWidth = pageRect.width * 0.8
    let aspectWidth = maxWidth / image.size.width
    let aspectHeight = maxHeight / image.size.height
    let aspectRatio = min(aspectWidth, aspectHeight)
    let scaledWidth = image.size.width * aspectRatio
    let scaledHeight = image.size.height * aspectRatio
    let imageX = (pageRect.width - scaledWidth) / 2.0
    let imageRect = CGRect(x: imageX, y: imageTop,
                           width: scaledWidth, height: scaledHeight)
    image.draw(in: imageRect)
    return imageRect.origin.y + imageRect.size.height
  }
  

}
