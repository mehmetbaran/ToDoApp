//
//  DetailVC.swift
//  ToDoApp
//
//  Created by Mehmet Baran on 3.05.2020.
//  Copyright © 2020 Mehmet Baran. All rights reserved.
//

import UIKit
import RealmSwift

class DetailVC: UIViewController {
    var choosenCell : ToDo?
    let realm = try! Realm()
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtSubTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setview()
    }
    
    //Action
    @IBAction func btnEditClicked(_ sender: Any) {
        
        if let choosenCell = choosenCell {
            do {
                try realm.write {
                    choosenCell.Name = txtTitle.text!
                    print("successfully updated. ")
                }
            } catch {
                print("update failed : \(error.localizedDescription)")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    //func
    func setview() {
        txtTitle.text = choosenCell?.Name
    }
}
