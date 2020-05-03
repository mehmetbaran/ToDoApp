//
//  ToDo.swift
//  ToDoApp
//
//  Created by Mehmet Baran on 3.05.2020.
//  Copyright © 2020 Mehmet Baran. All rights reserved.
//

import Foundation
import RealmSwift

class ToDo : Object {
   @objc dynamic var Name : String = ""
   @objc dynamic var Choose : Bool = false
}
