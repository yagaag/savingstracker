//
//  TargetController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 12/01/21.
//

import UIKit

class TargetController: UIViewController, UINavigationControllerDelegate, AddTargetControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onAddTarget(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addTarget", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addTarget" {
            let destinationVC = segue.destination as! AddTargetController
            destinationVC.delegate = self
        }
    }
    
    func reactToAddTarget(actionType: String, name: String, amount: String) {
        print("\(actionType), \(name), \(amount)")
        
    }
    
}
