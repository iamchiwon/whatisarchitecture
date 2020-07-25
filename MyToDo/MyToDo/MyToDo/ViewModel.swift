//
//  ViewModel.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

protocol ViewModelObserver {
    func updated()
}

protocol ViewModel {
    func didLoaded()
    func count() -> Int
    func todo(at index: Int) -> ToDo

    func create(title: String)
    func toggle(todo: ToDo)
    func update(title: String, todo: ToDo)
    func delete(todo: ToDo)
}

class ViewModelImpl: ViewModel {
    private var items: [ToDo] = []

    private var service: ToDoService
    private var observer: ViewModelObserver?

    init(service: ToDoService, observer: ViewModelObserver?) {
        self.service = service
        self.observer = observer
    }

    func didLoaded() {
        updateList()
    }

    private func updateList() {
        service.list { [weak self] items in
            self?.items = items
            self?.observer?.updated()
        }
    }

    func count() -> Int {
        return items.count
    }

    func todo(at index: Int) -> ToDo {
        return items[index]
    }

    func create(title: String) {
        service.create(title: title) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func toggle(todo: ToDo) {
        service.toggleCompleted(item: todo) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func update(title: String, todo: ToDo) {
        service.update(title: title, with: todo) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func delete(todo: ToDo) {
        service.delete(item: todo) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }
}
