//
//  DetailViewController.swift
//  BnetN
//
//  Created by Роман on 25.05.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var entry: Entry!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = entry.body
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func deletePressed(_ sender: Any) {
        Networking.removeEntryAF(id: entry.id) { entry in
        }
        dismiss(animated: true, completion: nil)
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
