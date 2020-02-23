//
//  HomeViewController.swift
//  AutoInspector
//
//  Created by Cesar on 13/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let evStoryBoard = UIStoryboard(name: "Events", bundle: nil)
    
    


    @IBOutlet weak var transitionBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
       
    }
    

    @IBAction func transitionToEvents(_ sender: Any) {
    //Creamos una variable que almacenara nuestro storyboard
        let nextViewController = evStoryBoard.instantiateViewController(withIdentifier: "eventsVC") as! EventsViewController
    //Configuramos el tipo de presentacion que queremos, en este caso será a pantalla completa y no modal
        nextViewController.modalPresentationStyle = .fullScreen
    //Presentamos el Storyboard
        self.present(nextViewController,animated:true,completion: nil)
        
    }
}
