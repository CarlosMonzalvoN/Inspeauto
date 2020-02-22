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

        // Do any additional setup after loading the view.
        
       
    }
    

    @IBAction func transitionToEvents(_ sender: Any) {
        
        let nextViewController = evStoryBoard.instantiateViewController(withIdentifier: "eventsVC") as! EventsViewController
        nextViewController.modalPresentationStyle = .fullScreen
               
        self.present(nextViewController,animated:true,completion: nil)
        
    }
}
