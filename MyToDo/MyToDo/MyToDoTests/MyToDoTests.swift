//
//  MyToDoTests.swift
//  MyToDoTests
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import XCTest
@testable import MyToDo

class MyToDoTests: XCTestCase {

    func test_ToDo를_json으로_만들기() {
        let createdAt = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createdAtString = formatter.string(from: createdAt)
        let str = "{\"id\":100,\"title\":\"title\",\"completed\":false,\"createdAt\":\"\(createdAtString)\"}"
        
        let todo = ToDo(id: 100,
                        title: "title",
                        completed: false,
                        createdAt: createdAt,
                        updatedAt: nil)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .formatted(formatter)
        let data = try! jsonEncoder.encode(todo)
        let json = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(str, json)
    }
    
    func test_json으로_ToDo_만들기() {
        let createdAt = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createdAtString = formatter.string(from: createdAt)
        let str = "{\"id\":100,\"title\":\"title\",\"completed\":false,\"createdAt\":\"\(createdAtString)\"}"
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        let data = str.data(using: .utf8)!
        let todo = try! jsonDecoder.decode(ToDo.self, from: data)
        
        XCTAssertNotNil(todo)
        XCTAssertEqual(todo.id, 100)
        XCTAssertEqual(todo.title, "title")
        XCTAssertEqual(todo.completed, false)
        XCTAssertEqual(formatter.string(from: todo.createdAt),
                       formatter.string(from: createdAt))
        XCTAssertNil(todo.updatedAt)
    }

}
