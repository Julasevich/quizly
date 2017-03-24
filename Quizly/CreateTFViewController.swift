//
//  CreateTFViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class CreateTFViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var createTFTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delegate
        createTFTable.delegate = self
        createTFTable.dataSource = self
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "createTFCell", for: indexPath) as! CreateTFTableViewCell
        if indexPath.row == 0{
            //Question Cell
            cell.textLabel?.text = "True"
        } else {
            //Add Question Cell
            cell.textLabel?.text = "False"
        }
        return cell
    }

}
