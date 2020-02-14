//
//  ViewController.swift
//  AutoInspector
//
//  Created by Cesar on 13/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupElements()
    }
    
    func setupElements(){
       
        //Aplicamos los estilos a el boton
        Styles.styleFilledButton(signupButton)
        Styles.styleHollowButton(loginButton)
    }


}

