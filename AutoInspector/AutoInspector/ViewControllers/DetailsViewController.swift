//
//  DetailsViewController.swift
//  AutoInspector
//
//  Created by Cesar on 23/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
//Importamos esta libreria para tener las funciones de seguridad de autenticacion local
import LocalAuthentication



class DetailsViewController: UIViewController {
    @IBOutlet weak var generateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


    @IBAction func generateBtnTapped(_ sender: Any) {
        

        let contxt: LAContext = LAContext()
        contxt.localizedCancelTitle = "Intenta cancelar"
        contxt.localizedFallbackTitle = "Intentar con passcode"
        
        if contxt.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            contxt.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Para Generar PDF con datos privados del usuario por favor confirme que es el dueño de este dispositivo") { (success, error) in
                if success{
                    showGoodAlert()
                    
                }else{
                    showBadAlert()
                }
            }
        }
        
        func showGoodAlert(){
            let alert = UIAlertController(title: "Autenticacion", message: "La autenticacion se realizo con exito", preferredStyle: .alert)
            let ok  = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(ok)
            DispatchQueue.main.async {
                //Presentamos la alerta a
                self.present(alert, animated: true)
            }
        }
        
        func showBadAlert(){
            
            let alert = UIAlertController(title: "Autenticacion", message: "La autenticacion fallo, intenta de nuevo", preferredStyle: .alert)
            let ok  = UIAlertAction(title: "intentar de nuevo", style: .default, handler: nil)
            alert.addAction(ok)
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert.addAction(cancel)
            DispatchQueue.main.async {
                //Presentamos la alerta
                self.present(alert, animated: true)
            }

        }
    }
    
}
