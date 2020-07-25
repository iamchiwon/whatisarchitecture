//
//  Repository.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

protocol Repository {
    func create(item: ToDo, completed: @escaping (Bool) -> Void)
    func read(completed: @escaping ([ToDo]) -> Void)
    func update(item: ToDo, completed: @escaping (Bool) -> Void)
    func delete(item: ToDo, completed: @escaping (Bool) -> Void)
}
