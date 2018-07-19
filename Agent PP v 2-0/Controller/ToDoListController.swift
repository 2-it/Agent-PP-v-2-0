//
//  ViewController.swift
//  Agent PP v 2-0
//
//  Created by Сергей Михайлов on 12.07.2018.
//  Copyright © 2018 Сергей Михайлов. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoListController: UITableViewController{
    let realm = try! Realm()
    var itemArray: Results<Item>?
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        navigationItem.title = selectedCategory?.name

    }
    
    // MARK: - IB Action
    @IBAction func AddBarItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавить адрес", message: "Введите адрес", preferredStyle: .alert)
        let alertActionCancel = UIAlertAction(title: "Отменить", style: .cancel)
        let alertAction = UIAlertAction(title: "Добавить", style: .default) { (addAction) in
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch{
                    print("Ошибка сохранения = \(error)")
                }


            }
 
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
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        if let item = itemArray?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        }else{
            cell.textLabel?.text = "Вы еще ничего не добавили"
        }
     

        return cell
    }
    //Mark: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = itemArray?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Ошибка сохранения done статуса = \(error)")
            }
        }
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)

    }
    //MARK: - Methods

    func loadItems(){
    
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    
        tableView.reloadData()
    }
    
    

}



//MARK:- Search bar Method

extension ToDoListController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemArray = itemArray?.filter("title CONTAINS %@", searchBar.text!).sorted(byKeyPath:"dateCreated" , ascending: true)
        tableView.reloadData()


    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
    
    
    
}

