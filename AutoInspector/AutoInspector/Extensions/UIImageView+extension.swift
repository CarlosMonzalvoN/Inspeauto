//
//  UIImageView+extension.swift
//  AutoInspector
//
//  Created by Pedro Carlos Monzalvo Navarro on 23/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//
import UIKit

extension UIImageView {
    func load(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
