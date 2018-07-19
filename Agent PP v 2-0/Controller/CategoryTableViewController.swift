//
//  CategoryTableViewController.swift
//  Agent PP v 2-0
//
//  Created by Сергей Михайлов on 16.07.2018.
//  Copyright © 2018 Сергей Михайлов. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var categoryArray: Results<Category>?


    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
    }
    func loadCategory(){
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    // MARK: -  Add new Category
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title:"Добавить адрес", message: "Введите название улицы", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Добавить", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            //self.categoryArray.append(newCategory)
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Введите Адрес"
            textField = alertTextField
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
 

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return categoryArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "Нет категорий"
        return cell
    }
    
    // MARK: - Table Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "GoToItems", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    // MARK: = Data Manipulation Method
    
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Ошибка сохранения категории \(error)")
        }
        tableView.reloadData()
    }

    
}
