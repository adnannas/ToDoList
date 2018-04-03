//
//  ViewController.swift
//  ToDoList
//
//  Created by Adnan Nasrullah on 8/3/18.
//  Copyright © 2018 Adnan Nasrullah. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item] ()//["SmartStore", "DesktopPOS", "Fix Issues"];
    let defaults = UserDefaults.standard
    let TO_DO_LIST_KEY = "ToDoListDefaultsKey"
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        print("dataFilePath \(dataFilePath)")

        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    saveItems()
    tableView.reloadData()
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var addTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = addTextField.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Create new Item"
            addTextField = textField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK saveItesm
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try  encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error \(error)")
        }
        
        tableView.reloadData()

    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decorder = PropertyListDecoder()
            do{
            itemArray = try decorder.decode([Item].self, from: data)
            }catch{
                print("Error in loadItems while decoding \(error)")
            }
        }
    }
    
}

