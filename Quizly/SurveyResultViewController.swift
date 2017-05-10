//
//  SurveyResultViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/9/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct surveyQuestion
{
    var id : String
    var text : String
    var type : String
    var responses = [String]()
    var intRespones = [String:Int]()
    var multChoiceOptions = [String]()
}

class SurveyResultViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var surveyResultTable: UITableView!
    var ref : FIRDatabaseReference!
    var surveyID : String!
    var questionList = [surveyQuestion]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeBtn:UIBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(home))
        self.navigationItem.rightBarButtonItems = [homeBtn]
        surveyResultTable.dataSource = self
        surveyResultTable.delegate = self
        getData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "surveyResultCell", for: indexPath) as! SurveyResultTableViewCell
        cell.questionLabel.text = questionList[indexPath.row].text
        
        if questionList[indexPath.row].type == "SA"
        {
            var resp = "Responses: "
            for r in questionList[indexPath.row].responses
            {
                if (r != "")
                {
                    resp += " " + r + ","
                }
            }
            resp.remove(at: resp.index(before: resp.endIndex))
            cell.tabLabel.text = resp
        }
        
        if questionList[indexPath.row].type == "RA"
        {
            var resp = "Responses: "
            for r in questionList[indexPath.row].responses
            {
                if (r != "")
                {
                    resp += " " + r + ","
                }
            }
            resp.remove(at: resp.index(before: resp.endIndex))
            print(resp)
            cell.tabLabel.text = resp
        }
        
        if questionList[indexPath.row].type == "TF"
        {
            var trues = 0
            var falses = 0
            if questionList[indexPath.row].intRespones["1"] != nil
            {
                falses = questionList[indexPath.row].intRespones["1"]!
            }
            if questionList[indexPath.row].intRespones["0"] != nil
            {
                trues = questionList[indexPath.row].intRespones["0"]!
            }
            
            var resp = "Responses: True: \(trues) False:\(falses)"
            
            cell.tabLabel.text = resp
        }
        
        if questionList[indexPath.row].type == "MC"
        {
            var resp = "Responses: "
            for k in questionList[indexPath.row].intRespones.keys
            {
                resp += "\(questionList[indexPath.row].multChoiceOptions[Int(k)!]) : \(questionList[indexPath.row].intRespones[k]!), "
            }
            cell.tabLabel.text = resp
        }
        
        if questionList[indexPath.row].type == "ES"
        {
            cell.tabLabel.text = "Essays Vary"
        }
        
        
        return cell
        
    }
    
    func getData()
    {
        ref = FIRDatabase.database().reference()
        
        //Get Lists
        ref.child("Survey").child(surveyID).child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let quizDict = snapshot.value as? NSDictionary {
                for id in (quizDict.allKeys as! [String])
                {
                    let name = (quizDict.value(forKey: id) as! NSDictionary).value(forKey: "text") as! String
                    let type = (quizDict.value(forKey: id) as! NSDictionary).value(forKey: "type") as! String
                    var opt = [String]()
                    if (type == "MC")
                    {
                        opt = (quizDict.value(forKey: id) as! NSDictionary).value(forKey: "options") as! [String]
                    }
                    
                    
                    //Disable matching and sa 
                    
                    if (type != "MT")
                    {
                        let question = surveyQuestion(id: id, text: name, type: type, responses: [], intRespones: [:], multChoiceOptions: opt)
                        self.questionList.append(question)
                    }
                    
                    
                }
            }
            
            //Get resp
                     self.ref.child("Results").observeSingleEvent(of: .value, with: { (snapshot) in
                        let dict = snapshot.value as! NSDictionary
                        let newDict = dict.allValues as! [NSDictionary]
                        var thisSurveyDictionary = [NSDictionary]()
                        for entry in newDict
                        {
                            print(" ")
                            let keys = entry.allKeys as! [String]
                            for k in keys {
                                if k == self.surveyID{
                                    thisSurveyDictionary.append(entry.value(forKey: k) as! NSDictionary)
                                }
                            }
                        }
                        for anEntry in thisSurveyDictionary
                        {
                            for index in 0...(self.questionList.count-1)
                            {
                                let finalEntry = anEntry
                                if let answer = finalEntry.object(forKey: self.questionList[index].id) as? NSDictionary
                                 {
                                    if self.questionList[index].type == "SA"
                                    {
                                        self.questionList[index].responses.append(answer.object(forKey: "answer") as! String)
                                    } else if self.questionList[index].type == "RA"
                                    {
                                        self.questionList[index].responses.append("(\((answer.object(forKey: "answer") as! [String]).joined(separator: ",")))")
                                    }
                                    else if self.questionList[index].type == "TF"
                                    {
                                        let theAnswerrrrr = answer.object(forKey: "answer") as! Int
                                        if (theAnswerrrrr == 0)
                                        {
                                            if (self.questionList[index].intRespones["0"] == nil)
                                            {
                                                self.questionList[index].intRespones["0"] = 1
                                            } else{
                                                self.questionList[index].intRespones["0"]! += 1
                                            }
                                        }else {
                                            if (self.questionList[index].intRespones["1"] == nil)
                                            {
                                                self.questionList[index].intRespones["1"] = 1
                                            } else{
                                                self.questionList[index].intRespones["1"]! += 1
                                            }
                                            
                                        }
                                        
                                    }else if self.questionList[index].type == "MC"{
                                        let theAnswerrrrr = answer.object(forKey: "answer") as! Int
                                        if self.questionList[index].intRespones["\(theAnswerrrrr)"] == nil{
                                            self.questionList[index].intRespones["\(theAnswerrrrr)"] = 1
                                        } else{
                                            self.questionList[index].intRespones["\(theAnswerrrrr)"]! += 1
                                        }
                                    }
                                }
                                
                            }
                        }
                        self.surveyResultTable.reloadData()
                     })
        })
        
        //Get data
        
    }
    

    func home() {
        self.performSegue(withIdentifier: "surveyResultsToHome", sender: self)
    }

}
