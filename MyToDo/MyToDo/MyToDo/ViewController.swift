//
//  ViewController.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    @IBOutlet var completebutton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    @IBAction func onCompleteSelected(sender: UIButton) {
        
    }
    
    @IBAction func onDeleteButton(sender: UIButton) {
    }
}

class ViewController: UITableViewController {
    
    var service: ToDoService!

    override func viewDidLoad() {
        guard service != nil else { fatalError("service must not be nil")}
        super.viewDidLoad()
    }


}

