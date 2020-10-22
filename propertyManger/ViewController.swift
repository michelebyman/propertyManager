//
//  ViewController.swift
//  propertyManger
//
//  Created by Michele Byman on 2020-10-13.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        

    }


}

