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

class ToDoServiceImpl: ToDoService {
    func create(title: String) {
        let todo = ToDo(id: 0,
                        title: title,
                        completed: false,
                        createdAt: Date(),
                        updatedAt: nil)
        // create todo
    }

    func list() -> [ToDo] {
        return []
        // read todo
    }

    func update(title: String, with item: ToDo) {
        let todo = ToDo(id: item.id,
                        title: title,
                        completed: item.completed,
                        createdAt: item.createdAt,
                        updatedAt: Date())
        // update todo
    }

    func toggleCompleted(item: ToDo) {
        let todo = ToDo(id: item.id,
                        title: item.title,
                        completed: !item.completed,
                        createdAt: item.createdAt,
                        updatedAt: Date())
        // update todo
    }

    func delete(item: ToDo) {
        // delete todo
    }
}
