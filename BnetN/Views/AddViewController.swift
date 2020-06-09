//
//  AddViewController.swift
//  BnetN
//
//  Created by Роман on 26.05.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var addTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTextField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        
        guard !addTextField.text!.isEmpty, let text = addTextField.text else { return }
        
        Networking.addEntryAF(text: text) { entry in
            
        }

        navigationController?.popViewController(animated: true)
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        if unwindSegue.identifier == "addSegue" {
            print("addSegue unwinded")
        }
    }

    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
