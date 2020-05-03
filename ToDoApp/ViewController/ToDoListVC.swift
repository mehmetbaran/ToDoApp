//
//  TableViewController.swift
//  ToDoApp
//
//  Created by Mehmet Baran on 2.05.2020.
//  Copyright © 2020 Mehmet Baran. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListVC: UITableViewController {
    var toDoList : Results<ToDo>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellList", for: indexPath)
        
        cell.textLabel?.text = toDoList?[indexPath.row].Name ?? "empty"
        
        if toDoList?[indexPath.row].Choose ?? false {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "detailVC" {
               let hedefVC = segue.destination as! DetailVC
               if let seciliIndex = tableView.indexPathForSelectedRow {
                   if let choosenCell = toDoList?[seciliIndex.row] {
                       hedefVC.choosenCell = choosenCell
                   }
               }
           }
       }
    
    //Action
    @IBAction func btnAddToDo(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "What would you like to do?", message: "take note!", preferredStyle: .alert)
        alertController.addTextField { txtToDoName in
            txtToDoName.placeholder = "please write here!"
        }
        
        let AddAction = UIAlertAction(title: "Add", style:.default) { action in
            let txtToDoName = alertController.textFields![0]
            if !txtToDoName.text!.isEmpty {
                let a1 = ToDo()
                a1.Name = txtToDoName.text!
                self.saveDate(todo : a1)
            }
             self.tableView.reloadData()
        }
        alertController.addAction(AddAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Add
    func saveDate(todo : ToDo) {
        do {
            try realm.write {
                realm.add(todo)
            }
        } catch {
            
        }
}
    //Upload
    func uploadData() {
        toDoList = realm.objects(ToDo.self)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
                   if let choosenCell = toDoList?[indexPath.row] {
                       do {
                         try realm.write {
                           realm.delete(choosenCell)
                           print("Deleted")
                           }
                       } catch {
                           print("Error : \(error.localizedDescription)")
                       }
                   }
               }
        tableView.reloadData()
    }
}



