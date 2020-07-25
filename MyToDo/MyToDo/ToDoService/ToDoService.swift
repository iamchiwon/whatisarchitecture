//
//  ToDoService.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

protocol ToDoService {
    func create(title: String,
                completed: @escaping (Bool) -> Void)

    func list(completed: @escaping ([ToDo]) -> Void)

    func update(title: String,
                with item: ToDo,
                completed: @escaping (Bool) -> Void)

    func toggleCompleted(item: ToDo,
                         completed: @escaping (Bool) -> Void)

    func delete(item: ToDo,
                completed: @escaping (Bool) -> Void)
}

class ToDoServiceImpl: ToDoService {
    var repository: Repository!

    init(repository: Repository) {
        self.repository = repository
    }

    func create(title: String, completed: @escaping (Bool) -> Void) {
        let todo = ToDo(id: 0,
                        title: title,
                        completed: false,
                        createdAt: Date(),
                        updatedAt: nil)
        repository.create(item: todo, completed: completed)
    }

    func list(completed: @escaping ([ToDo]) -> Void) {
        repository.read(completed: completed)
    }

    func update(title: String, with item: ToDo, completed: @escaping (Bool) -> Void) {
        let todo = ToDo(id: item.id,
                        title: title,
                        completed: item.completed,
                        createdAt: item.createdAt,
                        updatedAt: Date())
        repository.update(item: todo, completed: completed)
    }

    func toggleCompleted(item: ToDo, completed: @escaping (Bool) -> Void) {
        let todo = ToDo(id: item.id,
                        title: item.title,
                        completed: !item.completed,
                        createdAt: item.createdAt,
                        updatedAt: Date())
        repository.update(item: todo, completed: completed)
    }

    func delete(item: ToDo, completed: @escaping (Bool) -> Void) {
        repository.delete(item: item, completed: completed)
    }
}
