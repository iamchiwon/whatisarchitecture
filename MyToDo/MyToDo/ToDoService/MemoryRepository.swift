//
//  MemoryRepository.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

class MemoryRepository: Repository {
    var todos: [Int: ToDo] = [:]

    func create(item: ToDo, completed: @escaping (Bool) -> Void) {
        let todo = ToDo(id: todos.count,
                        title: item.title,
                        completed: item.completed,
                        createdAt: item.createdAt,
                        updatedAt: item.updatedAt)
        
        guard todos[todo.id] == nil else {
            completed(false)
            return
        }

        todos[todo.id] = todo
        completed(true)
    }

    func read(completed: @escaping ([ToDo]) -> Void) {
        completed(todos.compactMap { $1 })
    }

    func update(item: ToDo, completed: @escaping (Bool) -> Void) {
        guard todos[item.id] != nil else {
            completed(false)
            return
        }

        todos[item.id] = item
        completed(true)
    }

    func delete(item: ToDo, completed: @escaping (Bool) -> Void) {
        guard todos[item.id] != nil else {
            completed(false)
            return
        }

        todos.removeValue(forKey: item.id)
        completed(true)
    }
}
