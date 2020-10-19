//
//  RegisterPropertyAndTenants-ViewController.swift
//  Pods
//
//  Created by Michele Byman on 2020-10-16.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterPropertyAndTenants_ViewController: UIViewController {
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var refDataPropertyOwner = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Refeeeeeeee\(refDataPropertyOwner)")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addPropertyName(_ sender: Any) {
        let propertyGuestData = [
            "propertyName": "BOET",
           
        ] as [String : Any]
        print("teeeeeest\(refDataPropertyOwner)")
        // add buildings with documentId
        db.collection("propertyOwners").document(refDataPropertyOwner)
            .collection("properties").addDocument(data: propertyGuestData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(self.ref!.documentID)")
                    self.performSegue(withIdentifier: "registerProperty", sender: self)
                }
            }
    }
    
}
