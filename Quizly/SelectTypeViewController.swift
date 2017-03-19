//
//  SelectTypeViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class SelectTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //VARIABLES
    @IBOutlet weak var selectTypeTable: UITableView!
    var types = ["Quiz/Test", "Survey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delegate
        selectTypeTable.delegate = self
        selectTypeTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Item Type"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectTypeCell", for: indexPath) as! SelectTypeTableViewCell
        cell.textLabel?.text = types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "selectTypeToTitle", sender: self)
    }

}
