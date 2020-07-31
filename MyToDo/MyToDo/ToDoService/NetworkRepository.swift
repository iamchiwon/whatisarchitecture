//
//  NetworkRepository.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/31.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import Foundation

class NetworkRepository: Repository {
    private let TODO_URL = "https://us-central1-bearfried-b8ae1.cloudfunctions.net/api/todo"
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    private var encoder: JSONEncoder {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .formatted(formatter)
        return jsonEncoder
    }
    
    private var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        return jsonDecoder
    }

    func create(item: ToDo, completed: @escaping (Bool) -> Void) {
        let data: [String: Any] = [
            "title": item.title,
            "completed": item.completed,
            "createdAt": formatter.string(from: item.createdAt),
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: data)

        var request = URLRequest(url: URL(string: TODO_URL)!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completed(false)
                }
                return
            }
            DispatchQueue.main.async {
                completed(true)
            }
        }.resume()
    }

    func read(completed: @escaping ([ToDo]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: TODO_URL)!) { data, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completed([])
                }
                return
            }
            
            if let data = data,
                let todos = try? self.decoder.decode([ToDo].self, from: data) {
                DispatchQueue.main.async {
                    completed(todos)
                }
            } else {
                DispatchQueue.main.async {
                    completed([])
                }
            }
        }.resume()
    }

    func update(item: ToDo, completed: @escaping (Bool) -> Void) {
        guard let jsonData = try? encoder.encode(item) else {
            DispatchQueue.main.async {
                completed(false)
            }
            return
        }

        let url = "\(TODO_URL)/\(item.id)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { _, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completed(false)
                }
                return
            }
            DispatchQueue.main.async {
                completed(true)
            }
        }.resume()
    }

    func delete(item: ToDo, completed: @escaping (Bool) -> Void) {
        let url = "\(TODO_URL)/\(item.id)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { _, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completed(false)
                }
                return
            }
            DispatchQueue.main.async {
                completed(true)
            }
        }.resume()
    }
}
