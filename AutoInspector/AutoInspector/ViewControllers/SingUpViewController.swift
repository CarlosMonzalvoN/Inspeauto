//
//  SingUpViewController.swift
//  AutoInspector
//
//  Created by Cesar on 13/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

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
    
    //Verifica los campos y valida que los datos son correctos, si todo esta bien la funcion devuelve nil, en otro caso devuelve mensaje de error
    func validarCampos() -> String? {
        
        //Verificamos que los campos tienen datos
       
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
          || apellidoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
          || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
          || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Por favor llena todos los campos"
        }
        
        //Verificar si la contraseña es segura
        //*Usamos trimmingCharacters(in: .whitespacesAndNewlines) para limpiar de espacios y saltos de linea la contraseña del usuario*
        
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Styles.isPasswordValid(cleanPassword) == false {
            //La contraseña no es suficientemente segura
            return "introduce una contraseña con: al menos 8 caracteres ,un caracter especial y un numero"
        }
            
        
        return nil
    }
    

    @IBAction func signUpTapped(_ sender: Any) {
        
        //Validamos los campos
        let error = validarCampos()
        if error != nil{
            //Hubo un error en algun campo entonces mostramos mensaje de error
           showErrorMessage(error!)
            
        } else{
            
            //Limpiamos los datos del usuario
            let nombre = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let apellido = apellidoTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //Creamos el usuario
            //El closure se ejecutara una vez que hayamos creado el usuario
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //posibles errores
                if err != nil{
                    
                    //hubi un error creando el usuario
                    
                    self.showErrorMessage("Error al crear el usuario")
                }
                else {
                    //El usuario se creo sin problemas
                    //Iniciamos una instancia de la base de datos
                    let db = Firestore.firestore() 
                    
                    //Añadimos los datos a la bd
                    db.collection("users").addDocument(data: ["apellido": apellido,"nombre": nombre , "uid": result!.user.uid]) { (error) in
                        if error != nil{
                            //Si no se pudo guardaar alguno de los datos anteriores
                            self.showErrorMessage("Los datos del usuario no se pudieron guardar")
                        }
                    }
                    
                    
                //Presentamos el HomeScreen
                    self.transitionToHome()
                    
                    
                    
                }
            }
           
            
            
        }
       
    }
    
    func showErrorMessage(_ message: String){
            errorLabel.text = message
            errorLabel.alpha = 1
        
    }
    
    func transitionToHome (){
        
    //Instanciamos el homeVC
       let homeViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboards.homeViewController) as? HomeViewController
    //Hacemos el HomeVC el rootVC ahora
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
