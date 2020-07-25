//
//  ToDoService.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

protocol ToDoService {
    func create(title: String)
    func list() -> [ToDo]
    func update(title: String, with item: ToDo)
    func toggleCompleted(item: ToDo)
    func delete(item: ToDo)
}

class ToDoServiceImpl : ToDoService {
    func create(title: String) {
    }
    
    func list() -> [ToDo] {
        return []
    }
    
    func update(title: String, with item: ToDo) {
    }
    
    func toggleCompleted(item: ToDo) {
    }
    
    func delete(item: ToDo) {
    }
}
