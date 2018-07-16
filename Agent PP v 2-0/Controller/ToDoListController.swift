//
//  ViewController.swift
//  Agent PP v 2-0
//
//  Created by Сергей Михайлов on 12.07.2018.
//  Copyright © 2018 Сергей Михайлов. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController{
    var itemArray = [Item]()
    let defaultsSave = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Find mike2"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Find mike3"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find mike4"
        itemArray.append(newItem3)
        
        if let items = defaultsSave.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
            
        }
        
    }
    
    // MARK: - IB Action
    @IBAction func AddBarItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавить адрес", message: "Введите адрес", preferredStyle: .alert)
        let alertActionCancel = UIAlertAction(title: "Отменить", style: .cancel)
        let alertAction = UIAlertAction(title: "Добавить", style: .default) { (addAction) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaultsSave.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            
        }
      
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Добавить адрес"
            textField = alertTextField
        }
        
        alert.addAction(alertAction)
        alert.addAction(alertActionCancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Table View Data Sourse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        let item = itemArray[indexPath.row]
        cell.accessoryType = item.done == true ? .checkmark : .none

        return cell
    }
    //Mark: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
        

    }
}

