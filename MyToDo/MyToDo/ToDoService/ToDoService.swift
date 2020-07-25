//
//  ToDoService.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

protocol ToDo: Identifiable {
    var id: Int { get }
    var title: String { get }
    var completed: Bool { get }
    var createdAt: Date { get }
    var updatedAt: Date { get }
}

protocol ToDoService {
    func list() -> [ToDo]
    func toggleCompleted(id: Int)
    func delete(id: Int)
}
