//
//  pdfPreviewViewController.swift
//  AutoInspector
//
//  Created by Cesar on 23/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import PDFKit


class pdfPreviewViewController: UIViewController {
    
    public var documentData: Data?
    @IBOutlet weak var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Funcion para PDF PReview
      if let data = documentData {
              pdfView.document = PDFDocument(data: data)
              pdfView.autoScales = true
            pdfView.backgroundColor = UIColor.myBlue
        view.backgroundColor = .myBlue
            }

       
    }
    

    

}
