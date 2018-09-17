//
//  ViewController.swift
//  Todey
//
//  Created by Kang Paul on 2018/9/17.
//  Copyright © 2018年 Kang Paul. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //var itemArray = ["Todo 1", "Todo 2", "Todo 3"]
    //var doneArray = [true, false, true, false, true]
    var itemArray = [String]()
    var doneArray = [Bool]()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        if let dones = defaults.array(forKey: "TodoListDone") as? [Bool] {
            doneArray = dones
        }
        //tableView.separatorStyle = .singleLine
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        cell.accessoryType = doneArray[indexPath.row] ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        doneArray[indexPath.row] = !doneArray[indexPath.row]
        
        defaults.set(self.doneArray, forKey: "TodoListDone")
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("add item")
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //let newItem = Item()
            //newItem.title = textField.text!
            //self.itemArray.append(newItem)
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.doneArray.append(false)
            self.defaults.set(self.doneArray, forKey: "TodoListDone")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}

