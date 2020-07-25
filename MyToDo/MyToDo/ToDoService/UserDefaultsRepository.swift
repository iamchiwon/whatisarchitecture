//
//  UserDefaultsRepository.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/26.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

fileprivate let TODO_SAVE_KEY = "TODOS"

class UserDefaultsRepository: Repository {
    var todos: [Int: ToDo] = [:]

    private func save(completed: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            let jsonEncoder = JSONEncoder()
            if let data = try? jsonEncoder.encode(self.todos) {
                UserDefaults.standard.set(data, forKey: TODO_SAVE_KEY)
            }

            DispatchQueue.main.async {
                completed(true)
            }
        }
    }

    private func load(completed: @escaping ([Int: ToDo]) -> Void) {
        DispatchQueue.global().async {
            let jsonDecoder = JSONDecoder()
            guard let data = UserDefaults.standard.data(forKey: TODO_SAVE_KEY),
                let items = try? jsonDecoder.decode([Int: ToDo].self, from: data) else {
                completed([:])
                return
            }

            DispatchQueue.main.async {
                completed(items)
            }
        }
    }

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
        save(completed: completed)
    }

    func read(completed: @escaping ([ToDo]) -> Void) {
        load { items in
            self.todos = items
            completed(items.compactMap { $1 })
        }
    }

    func update(item: ToDo, completed: @escaping (Bool) -> Void) {
        guard todos[item.id] != nil else {
            completed(false)
            return
        }

        todos[item.id] = item
        save(completed: completed)
    }

    func delete(item: ToDo, completed: @escaping (Bool) -> Void) {
        guard todos[item.id] != nil else {
            completed(false)
            return
        }

        todos.removeValue(forKey: item.id)
        save(completed: completed)
    }
}
