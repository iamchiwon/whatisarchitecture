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
    var viewModel: ViewModel!

    override func viewDidLoad() {
        guard viewModel != nil else { fatalError("viewModel must not be nil") }
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didLoaded()
    }

    @IBAction func onAddToDo(sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "TitleInputViewController") as! TitleInputViewController
        if let updateItem = sender as? ToDo {
            vc.updateItem = updateItem
            vc.onTitleInput = { [weak self] in self?.viewModel.update(title: $0, todo: updateItem) }
        } else {
            vc.onTitleInput = { [weak self] in self?.viewModel.create(title: $0) }
        }

        present(vc, animated: true, completion: nil)
    }
}

extension ViewController: ViewModelObserver {
    func updated() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell

        let todo = viewModel.todo(at: indexPath.row)
        cell.titleLabel.text = todo.title
        cell.dateLabel.text = todo.dateText()
        cell.completebutton.isSelected = todo.completed
        cell.onToggleCompleted = { [weak self] in
            self?.viewModel.toggle(todo: todo)
        }
        cell.onDelete = { [weak self] in
            self?.viewModel.delete(todo: todo)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todo = viewModel.todo(at: indexPath.row)
        onAddToDo(sender: todo)
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
