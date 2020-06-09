//
//  MainTableViewController.swift
//  BnetN
//
//  Created by Роман on 24.05.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var entries = [Entry]() 
    
    func presentAlert(message: String) {
        let errorAlertController = UIAlertController(title: "alert controller", message: "\(message)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "retry", style: .default) { (action) in
            self.reloadData()
        }
        errorAlertController.addAction(alertAction)
        present(errorAlertController, animated: true) {
            print("presented")
        }
    }
    
    func reloadData() {
        
        Networking.getEntriesResult { (result) in
            switch result {
            case .success(let data): print(data)
            guard let arr = NetworkingCore.dataToEntry(res: data) else {return}
            print(arr)
            print("data returned")
            self.entries = arr
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                }
                
            case .failure(let error):
                let errorDescription = error.localizedDescription.uppercased()
                self.presentAlert(message: errorDescription)
            }
        }
    }
    
    var keyS: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        retrieveNewSessionKey { str in
            if let str = str {
                self.keyS = str
                
                if let keyZ = self.keyS {
                    print(keyZ)
                    UserDefaults.standard.set(keyZ, forKey: "key")
                }
            }
        }
        
        reloadData()
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let currentEntry = entries[indexPath.row]
        cell.textLabel?.text = populateCellWithDates(da: currentEntry.da, dm: currentEntry.dm)
        cell.detailTextLabel?.text = String(currentEntry.body.prefix(200))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let destinationVC = segue.destination as? DetailViewController,
                let index = tableView.indexPathForSelectedRow else {return}
            destinationVC.entry = entries[index.row]
            tableView.deselectRow(at: index, animated: true)
            
        }
    }
    
    func UnixTimeToString(incomingDate: String) -> String {
        if let resAsInt = Int(incomingDate) {
            let dateRes = Date(timeIntervalSince1970: TimeInterval(resAsInt))
            let format = DateFormatter()
            format.dateStyle = .medium
            let result = format.string(from: dateRes).localizedUppercase
            return result
        } else {
            return "this is not working, jon"
        }
    }
    
    func populateCellWithDates (da: String, dm: String) -> String{
        switch da == dm {
        case true:
            return "DATE \(UnixTimeToString(incomingDate: da))"
        default:
            return "CREATED \(UnixTimeToString(incomingDate: da)), MODIFIED \(UnixTimeToString(incomingDate: dm))"
        }
    }
    
}
