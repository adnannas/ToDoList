//
//  ViewController.swift
//  ToDoList
//
//  Created by Adnan Nasrullah on 8/3/18.
//  Copyright © 2018 Adnan Nasrullah. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["SmartStore", "DesktopPOS", "Fix Issues"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }else{
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
