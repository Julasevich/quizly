//
//  CreateMTViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class CreateMTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var createMTTable: UITableView!
    var options = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate
        createMTTable.delegate = self
        createMTTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Edit Options"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != options.count{
            //Question Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "createMTCell", for: indexPath) as! CreateMTTableViewCell
            cell.textLabel?.text = "\(options[indexPath.row])"
            return cell
        } else {
            //Add Question Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "addAnswerCell", for: indexPath) 
            cell.textLabel?.text = "Add Answer"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == options.count {
            createMTTable.beginUpdates()
            createMTTable.insertRows(at: [IndexPath(row: options.count, section:0)], with: .automatic)
            options.append("")
            createMTTable.endUpdates()
        }
        
    }

}
