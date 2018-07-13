//
//  ViewController.swift
//  Agent PP v 2-0
//
//  Created by Сергей Михайлов on 12.07.2018.
//  Copyright © 2018 Сергей Михайлов. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController{
    var itemArray = ["Find mike", "Buy Eggs", "Destroy Demogrogon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - IB Action
    @IBAction func AddBarItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавить адрес", message: "Введите адрес", preferredStyle: .alert)
        let alertActionCancel = UIAlertAction(title: "Отменить", style: .cancel)
        let alertAction = UIAlertAction(title: "Добавить", style: .default) { (addAction) in

               self.itemArray.append(textField.text!)
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    //Mark: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = itemArray[indexPath.row]

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(cell)
    }
}

