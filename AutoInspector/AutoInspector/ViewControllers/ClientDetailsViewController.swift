//
//  ClientDetailsViewController.swift
//  AutoInspector
//
//  Created by Pedro Carlos Monzalvo Navarro on 23/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class ClientDetailsViewController: UIViewController {
    @IBOutlet weak var clientImageView : UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var lastname : UILabel!
    
    var client : ClientModel = ClientModel()
    
    func loadData(){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        db.collection("users").whereField("uid", isEqualTo: userID)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let decoder = JSONDecoder()
                    for document in querySnapshot!.documents {
                        if let data = try?  JSONSerialization.data(withJSONObject: document.data(), options: []) {
                            guard let client = try? decoder.decode(ClientModel.self, from: data) else { return }
                            self.client = client
                            self.updateUI()
                        }
                    }
                }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clientImageView.setRounded()
        loadData()
    }
    
    private func updateUI(){
        DispatchQueue.main.async {
            self.name.text = self.client.name
            self.lastname.text = self.client.lastname
            self.clientImageView.load(self.client.photoUrl ?? "")
        }
    }
    
}
