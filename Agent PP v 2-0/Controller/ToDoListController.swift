//
//  ViewController.swift
//  Agent PP v 2-0
//
//  Created by Сергей Михайлов on 12.07.2018.
//  Copyright © 2018 Сергей Михайлов. All rights reserved.
//

import UIKit
import CoreData
class ToDoListController: UITableViewController{
    
    var itemArray = [Item]()
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
    //   itemArray.remove(at: indexPath.row)
    //   context.delete(itemArray[indexPath.row])
    //   itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)

    }
    //MARK: - Methods
    func saveItems(){
        do{
            try context.save()
        }catch{
           print("Ошибка сохранения \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let  additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        

        do{
            itemArray =  try context.fetch(request)
        }catch{
            print("Ошибка приема \(error)")
        }
        tableView.reloadData()
    }
    
    

}



//MARK:- Search bar Method

extension ToDoListController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)

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

