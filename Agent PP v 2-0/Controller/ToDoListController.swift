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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(dataFilePath)

        
        loadItems()

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
            
            self.saveItems()

            
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
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
        

    }
    //MARK: - Methods
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Ошибка запись в файл \(error.localizedDescription)")
        }
        self.tableView.reloadData()
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
               itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                   print("Ошибка дикодера \(error)")
            }
            
        }
    }
}

