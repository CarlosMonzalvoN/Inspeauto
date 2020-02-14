//
//  SingUpViewController.swift
//  AutoInspector
//
//  Created by Cesar on 13/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupElements()
    }
    
    func setupElements(){
     //ocultamos el label de error mientras no haya uno
        errorLabel.alpha = 0
    //Aplicamos los estilos a los texfields
        Styles.styleTextField(nameTextField)
        Styles.styleTextField(apellidoTextField)
        Styles.styleTextField(emailTextField)
        Styles.styleTextField(passwordTextField)
    //Aplicamos los estilos a el boton
        Styles.styleFilledButton(signUpButton)
    
        
        
    }
    

    @IBAction func signUpTapped(_ sender: Any) {
    }
    
}
