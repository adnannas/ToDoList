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
    let defaults = UserDefaults.standard
    let TO_DO_LIST_KEY = "ToDoListDefaultsKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: TO_DO_LIST_KEY) as? [String]{
            itemArray = items
        }
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
    
    // MARK - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var addTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(addTextField.text!)
            
            self.defaults.setValue(self.itemArray, forKey: self.TO_DO_LIST_KEY)
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Create new Item"
            addTextField = textField
        }
        
        present(alert, animated: true, completion: nil)
    }
}

