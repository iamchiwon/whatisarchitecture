//
//  ToDoService.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

protocol ToDoService {
    func list() -> [Any]
    func completed(item: Any)
    func delete(item: Any)
}
