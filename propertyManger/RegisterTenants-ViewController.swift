//
//  RegisterTenants-ViewController.swift
//  propertyManger
//
//  Created by Michele Byman on 2020-10-21.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterTenants_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var refDataPropertyOwner = ""
    var propertyName: String? = ""
    var tenantsName = [String]()
  
    
    @IBOutlet weak var propertyNameHeader: UILabel!
    
    
    @IBOutlet weak var tenantName: UITextField!
    @IBOutlet weak var tenantEmail: UITextField!
    @IBOutlet weak var tenantPhoneNumber: UITextField!

    @IBOutlet weak var tenantsTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertyNameHeader.text = (propertyName!.uppercased() as String)
        tenantsTabelView.dataSource = self
        tenantsTabelView.delegate = self
        
    }
    
    
    @IBAction func addTenant(_ sender: Any) {
        let propertyTenant = [
            "name" : tenantName.text!,
            "email" : tenantEmail.text!,
            "phoneNumber": Int(tenantPhoneNumber.text!) as Any
        ]
        
        let propertyRef = db.collection("propertyOwners")
            .document(refDataPropertyOwner)
            .collection("properties")
            .document(propertyName!)

        // Atomically add a new tenants to the "propertyTenants" array field.
        propertyRef.updateData(["propertyTenants": FieldValue.arrayUnion([propertyTenant])]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        self.tenantsName.append(tenantName.text!)
        self.tenantsTabelView.reloadData()
        tenantName.text! = ""
        tenantEmail.text! = ""
        tenantPhoneNumber.text! = ""
        
     }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tenantsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tenantsCell") as! Tanants_TableViewCell
        cell.tenantsCellLavel.text = tenantsName[indexPath.row]
        return cell
    }
    

}
