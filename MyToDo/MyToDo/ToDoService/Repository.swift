//
//  Repository.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

protocol Repository {
    func create(item: ToDo)
    func read() -> [ToDo]
    func update(item: ToDo)
    func delete(item: ToDo)
}
