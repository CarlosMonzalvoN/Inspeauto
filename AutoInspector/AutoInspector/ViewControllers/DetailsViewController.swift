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
import PDFKit




class DetailsViewController: UIViewController {
    


    
    @IBOutlet weak var nameTextEntry: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var generateBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Styles.styleTextField(nameTextEntry)
        Styles.styleTextField(modelTextField)
        
    }
//Funcion para compartir
 func shareAction() {

      guard let title = nameTextEntry.text, let body = bodyTextView.text,
        let image = imagePreview.image,let model = modelTextField.text
        else {

          let alert = UIAlertController(title: "All Information Not Provided", message: "You must supply all information to create a flyer.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          present(alert, animated: true, completion: nil)
          return
      }
    let pdfCreator = PDFCreator(title: title, body: body, image: image, model: model)
      let pdfData = pdfCreator.createPDF()
      let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
      present(vc, animated: true, completion: nil)
    }
    


    @IBAction func generateBtnTapped(_ sender: Any) {

        let contxt: LAContext = LAContext()
        contxt.localizedCancelTitle = "Intenta cancelar"
        contxt.localizedFallbackTitle = "Intentar con passcode"
        
        if contxt.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            contxt.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Para Generar PDF con datos privados del usuario por favor confirme que es el dueño de este dispositivo") { (success, error) in
                if success{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        
                    showGoodAlert()
                        
                    }
                     
                    
                }else{
                    showBadAlert()
                }
            }
        }
        
        
        func showGoodAlert(){
            let alert = UIAlertController(title: "Autenticacion", message: "La autenticacion se realizo con exito", preferredStyle: .alert)
           
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { [weak alert, weak self] (_) in
                self?.shareAction()
            }))
            
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
        
    }//EndfuncGenerateButtonTapped
    
    
    @IBAction func backArrowBtnTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectImageTouched(_ sender: Any) {
      let actionSheet = UIAlertController(title: "Select Photo", message: "Where do you want to select a photo?", preferredStyle: .actionSheet)
      
      let photoAction = UIAlertAction(title: "Photos", style: .default) { (action) in
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
          let photoPicker = UIImagePickerController()
          photoPicker.delegate = self
          photoPicker.sourceType = .photoLibrary
          photoPicker.allowsEditing = false
          
          self.present(photoPicker, animated: true, completion: nil)
        }
      }
      actionSheet.addAction(photoAction)
      
      let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
          let cameraPicker = UIImagePickerController()
          cameraPicker.delegate = self
          cameraPicker.sourceType = .camera
          
          self.present(cameraPicker, animated: true, completion: nil)
        }
      }
      actionSheet.addAction(cameraAction)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      actionSheet.addAction(cancelAction)
      
      self.present(actionSheet, animated: true, completion: nil)
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "previewSegue" {
        guard let vc = segue.destination as? pdfPreviewViewController else { return }
        
        if let title = nameTextEntry.text, let body = bodyTextView.text,
          let image = imagePreview.image, let model = modelTextField.text {
          let pdfCreator = PDFCreator(title: title, body: body,
                                      image: image, model: model)
          vc.documentData = pdfCreator.createPDF()
        }
      }
    }
    
    
    
    

}


extension DetailsViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    
    guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      return
    }
    
    imagePreview.image = selectedImage
    imagePreview.isHidden = false
    
    dismiss(animated: true, completion: nil)
  }
}


