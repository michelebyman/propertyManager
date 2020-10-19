//
//  RegisterProperty-ViewController.swift
//  propertyManger
//
//  Created by Michele Byman on 2020-10-14.
//

import UIKit
import FirebaseFirestore
import Firebase

class RegisterProperty_ViewController: UIViewController {

 
    @IBOutlet weak var companyName: UITextField!
    
    @IBOutlet weak var propertyOwnerName: UITextField!
    
    @IBOutlet weak var propertyOwnerLastName: UITextField!
    
    @IBOutlet weak var propertyOwnerEmail: UITextField!
    
    @IBOutlet weak var propertyOwnerPhonenumber: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var backgorundView: UIView!
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var refData = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        errorMessage.isHidden = true
        setupBackGroundTouch()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func registerPropertyAndOwnerDetails(_ sender: Any) {
        // Add a new document with a generated ID
        if validateTextfield() {
            
            let propertyData = [
                "companyName": companyName.text!,
                "firstName": propertyOwnerName.text!,
                "lastName": propertyOwnerLastName.text!,
                "email": propertyOwnerEmail.text!,
                "phonenumber": Int(propertyOwnerPhonenumber.text!)!
            ] as [String : Any]
            
            ref = db.collection("propertyOwners").addDocument(data: propertyData) { [self] err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(self.ref!.documentID)")
                    refData = self.ref!.documentID
                    self.performSegue(withIdentifier: "registerProperty", sender: self)
                }
            }
        } else {
            errorMessage.isHidden = false
            errorMessage.textColor = UIColor.red
            errorMessage.text = "Fälten är inte korrekt ifyllda"
            print("Fill in all the fields!")
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RegisterPropertyAndTenants_ViewController
        destination.refDataPropertyOwner = refData
    }
    
    private func validateTextfield() -> Bool {
           return (companyName.text != "" && propertyOwnerName.text != "" && propertyOwnerEmail.text != "" && propertyOwnerPhonenumber.text != "" && propertyOwnerLastName.text! != "")
       }
    
    func setupBackGroundTouch(){
        backgorundView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
            // add to imageView
        backgorundView.addGestureRecognizer(tapGesture)
        }
        
        @objc func backgroundTap(){
            dismissKeyboard()
        }
        
        @objc private func dismissKeyboard(){
            self.view.endEditing(false)
        }
}
