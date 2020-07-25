//
//  ViewController.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    var onToggleCompleted: (() -> Void)?
    var onDelete: (() -> Void)?

    @IBOutlet var completebutton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!

    @IBAction func onCompleteSelected(sender: UIButton) {
        onToggleCompleted?()
    }

    @IBAction func onDeleteButton(sender: UIButton) {
        onDelete?()
    }
}

class ViewController: UITableViewController {
    var service: ToDoService!

    var todos: [ToDo] = []

    override func viewDidLoad() {
        guard service != nil else { fatalError("service must not be nil") }
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateList()
    }

    @IBAction func onAddToDo(sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "TitleInputViewController") as! TitleInputViewController
        vc.onTitleInput = { [weak self] in self?.addTodoAndUpdate(title: $0) }
        present(vc, animated: true, completion: nil)
    }

    func addTodoAndUpdate(title: String) {
        service.create(title: title) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func updateList() {
        service.list { [weak self] list in
            self?.todos = list
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell

        let todo = todos[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.dateLabel.text = todo.dateText()
        cell.completebutton.isSelected = todo.completed
        cell.onToggleCompleted = { [weak self] in
            self?.service.toggleCompleted(item: todo,
                                          completed: { success in
                                              guard success else { return }
                                              self?.updateList()
            })
        }
        cell.onDelete = { [weak self] in
            self?.service.delete(item: todo, completed: { success in
                guard success else { return }
                self?.updateList()
            })
        }

        return cell
    }
}

// MARK: - ToDo extension

extension ToDo {
    func dateText() -> String {
        let displayDate = updatedAt ?? createdAt

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"

        return formatter.string(from: displayDate)
    }
}
