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
                            let client = try? decoder.decode(ClientModel.self, from: data)
                            self.client.name = client?.name
                            self.client.lastname = client?.lastname
                            self.client.photoUrl = client?.photoUrl
                        }
                    }
                }
        }
        name.text = client.name
        lastname.text = client.lastname
        clientImageView.load(client.photoUrl ?? "")
        print(client)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clientImageView.setRounded()
        loadData()
    }
    
}
