//
//  ToDo.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

struct ToDo: Identifiable, Codable {
    let id: Int
    let title: String
    let completed: Bool
    let createdAt: Date
    let updatedAt: Date?
}
