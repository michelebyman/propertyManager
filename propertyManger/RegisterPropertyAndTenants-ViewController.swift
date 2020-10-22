//
//  RegisterPropertyAndTenants-ViewController.swift
//  Pods
//
//  Created by Michele Byman on 2020-10-16.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterPropertyAndTenants_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var refDataPropertyOwner = ""
    var rows: Int? = nil
    var propertyNamesForCells = [String]()
    var propertyNameForSavingTenants: String? = ""
 
    @IBOutlet weak var propertyName: UITextField!

    @IBOutlet weak var propertyNameTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Refeeeeeeee\(refDataPropertyOwner)")
        // Do any additional setup after loading the view.
        propertyNameTabelView.dataSource = self
        propertyNameTabelView.delegate = self
        propertyNameTabelView.reloadData()
    }
    
    
    @IBAction func addPropertyName(_ sender: Any) {
        let propertyTenant =  ["propertyTenants": []]
       
        db.collection("propertyOwners")
        .document(refDataPropertyOwner)
        .collection("properties")
        .document(propertyName.text!)
        .setData(propertyTenant) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.getPropertNames()
            }
        }
        propertyName.text = ""
    }
    
    func getPropertNames()  {
        db.collection("propertyOwners")
            .document(refDataPropertyOwner)
            .collection("properties")
            .getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.propertyNamesForCells.removeAll()
                for document in querySnapshot!.documents {
                   print("--------\(document.documentID) => \(document.data())")
                    let tenants = document.data()
                    for tenant in (tenants) {
                        print("Tenants infos_______\(tenant.value)")
                    }
                    self.propertyNamesForCells.append(document.documentID)
                    self.propertyNameTabelView.reloadData()
                }
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let registerTenants = segue.destination as! RegisterTenants_ViewController
        registerTenants.propertyName = propertyNameForSavingTenants
        registerTenants.refDataPropertyOwner = refDataPropertyOwner
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(propertyNamesForCells[indexPath.row])
        propertyNameForSavingTenants = propertyNamesForCells[indexPath.row]
        performSegue(withIdentifier: "registerTenants", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyNamesForCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyNameCell") as! PropertyName_TableViewCell
        cell.propertyNameLabel.text = propertyNamesForCells[indexPath.row].uppercased()
        return cell
    }
}

