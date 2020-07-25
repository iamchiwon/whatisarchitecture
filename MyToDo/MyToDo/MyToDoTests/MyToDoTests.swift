//
//  MyToDoTests.swift
//  MyToDoTests
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

@testable import MyToDo
import XCTest

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

    func test_ToDo_만들고_저장하기() {
        let repository: Repository = MemoryRepository()
        let service: ToDoService = ToDoServiceImpl(repository: repository)
        let expectation = self.expectation(description: #function)

        let title = "HelloWorld"
        service.create(title: title) { success in
            XCTAssertTrue(success)

            service.list { list in
                XCTAssertEqual(list.count, 1)
                XCTAssertEqual(list[0].title, "HelloWorld")
                XCTAssertEqual(list[0].completed, false)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
    }

    func test_ToDo_만들고_완료하기() {
        let repository: Repository = MemoryRepository()
        let service: ToDoService = ToDoServiceImpl(repository: repository)
        let expectation = self.expectation(description: #function)

        service.create(title: "HelloWorld") { success in
            XCTAssertTrue(success)

            service.list { list in
                XCTAssertEqual(list.count, 1)

                service.toggleCompleted(item: list[0]) { success in
                    XCTAssertTrue(success)

                    service.list { list2 in
                        XCTAssertEqual(list2.count, 1)
                        XCTAssertEqual(list2[0].title, "HelloWorld")
                        XCTAssertEqual(list2[0].completed, true)
                        expectation.fulfill()
                    }
                }
            }
        }

        waitForExpectations(timeout: 10)
    }

    func test_ToDo_만들고_제목_변경하기() {
        let repository: Repository = MemoryRepository()
        let service: ToDoService = ToDoServiceImpl(repository: repository)
        async { done in
            service.create(title: "HelloWorld") { success in
                XCTAssertTrue(success)

                service.list { list in
                    XCTAssertEqual(list.count, 1)

                    service.update(title: "WorldHello", with: list[0]) { success in
                        XCTAssertTrue(success)

                        service.list { list2 in
                            XCTAssertEqual(list2.count, 1)
                            XCTAssertEqual(list2[0].title, "WorldHello")
                            XCTAssertNotNil(list2[0])

                            done()
                        }
                    }
                }
            }
        }
    }
    
    func test_ToDo_만들고_삭제하기() {
        let repository: Repository = MemoryRepository()
        let service: ToDoService = ToDoServiceImpl(repository: repository)
        async { done in
            service.create(title: "HelloWorld") { success in
                XCTAssertTrue(success)

                service.list { list in
                    XCTAssertEqual(list.count, 1)

                    service.delete(item: list[0]) { (success) in
                        XCTAssertTrue(success)
                        
                        service.list { list2 in
                            XCTAssertEqual(list2.count, 0)

                            done()
                        }
                    }
                }
            }
        }
    }
}
