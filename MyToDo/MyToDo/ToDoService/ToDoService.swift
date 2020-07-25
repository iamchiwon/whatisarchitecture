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
    var repository: Repository!

    init(repository: Repository) {
        self.repository = repository
    }

    func create(title: String) {
        let todo = ToDo(id: 0,
                        title: title,
                        completed: false,
                        createdAt: Date(),
                        updatedAt: nil)
        repository.create(item: todo)
    }

    func list() -> [ToDo] {
        return repository.read()
    }

    func update(title: String, with item: ToDo) {
        let todo = ToDo(id: item.id,
                        title: title,
                        completed: item.completed,
                        createdAt: item.createdAt,
                        updatedAt: Date())
        repository.update(item: todo)
    }

    func toggleCompleted(item: ToDo) {
        let todo = ToDo(id: item.id,
                        title: item.title,
                        completed: !item.completed,
                        createdAt: item.createdAt,
                        updatedAt: Date())
        repository.update(item: todo)
    }

    func delete(item: ToDo) {
        repository.delete(item: item)
    }
}
