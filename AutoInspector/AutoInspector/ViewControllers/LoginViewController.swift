//
//  LoginViewController.swift
//  AutoInspector
//
//  Created by Cesar on 13/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
   func setupElements(){
    
            //ocultamos el label de error mientras no haya uno
            errorLabel.alpha = 0
            //Aplicamos los estilos a los texfields
            Styles.styleTextField(emailTextField)
            Styles.styleTextField(passwordTextField)
            //Aplicamos los estilos a el boton
            Styles.styleFilledButton(loginButton)
    
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        //Validamos los texfields
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
          || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            errorLabel.text =  "Por favor llena todos los campos"
            errorLabel.alpha = 1
        }
        
        //Limpiamos los textfields
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Entramos con el usuario logeado
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //No se pudo iniciar session
                self.errorLabel.text =  error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                //Si no hubo error vamos al homeVC
                self.errorLabel.textColor = .green
                self.errorLabel.text =  "Verificado"
                self.errorLabel.alpha = 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                      //Instanciamos el homeVC
                                let homeViewController =  self.storyboard?.instantiateViewController(identifier: Constants.Storyboards.homeViewController) as? HomeViewController
                                  //Hacemos el HomeVC el rootVC ahora
                                  self.view.window?.rootViewController = homeViewController
                                  self.view.window?.makeKeyAndVisible()
                }
              
            }
        }
    }
    
    
    

}
