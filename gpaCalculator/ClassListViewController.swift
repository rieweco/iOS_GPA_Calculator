//
//  ViewController.swift
//  gpaCalculator
//
//  Created by cody riewerts on 7/31/17.
//  Copyright © 2017 cody riewerts. All rights reserved.
//

import UIKit

class ClassListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentGPALabel: UILabel!
    @IBOutlet weak var currentHoursLabel: UILabel!
    @IBOutlet weak var projectedGPAButton: UIButton!
    
    @IBOutlet weak var currentHoursValueLabel: UILabel!
    @IBOutlet weak var currentGPAValueLabel: UILabel!
    

    @IBOutlet weak var projectedGPAValueLabel: UILabel!
    
    
    
    fileprivate var model: ClassListModelInterface = ClassListModel()
    var grades: Double = 0.00
    var gradesPointValue: Double = 0.00
    var totalHours: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 64
        currentGPAValueLabel.text = ""
        currentHoursValueLabel.text = ""
        
        
        
        if let GPAField = Double(currentGPAValueLabel.text!) {
            if let hoursField = Int(currentHoursValueLabel.text!) {
                gradesPointValue = GPAField * Double(hoursField)
                totalHours = hoursField
                print(gradesPointValue)
                print(totalHours)
                
            }
            else { print("Current Hours is Empty") }
        }
        else { print("Current GPA is Empty") }
    

    
        view.backgroundColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        currentGPALabel.textColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        currentHoursLabel.textColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        projectedGPAButton.setTitleColor(UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0), for: .normal)
    }
    
    
    //********************************************************************
    //Projected GPA Button Pressed
    //  print statements commented out
    //      ...remove the '//' to see how values change...
    //********************************************************************
    
    @IBAction func projectedGPAButtonClicked(_ sender: UIButton) {
        if let GPAField = Double(currentGPAValueLabel.text!) {
            if let hoursField = Int(currentHoursValueLabel.text!) {
                gradesPointValue = GPAField * Double(hoursField)
                totalHours = hoursField
                print("gradesPointValue if let: \(gradesPointValue)")
                print("totalHours if let: \(totalHours)")
                
            }
            else { print("Current Hours is Empty") }
        }
        else { print("Current GPA is Empty") }
        totalHours = totalHours + model.findTotalHours()
        print("findTotalPoints: \(model.findTotalPoints())")
        print("findTotalHours: \(model.findTotalHours())")
        
       
        
        var classCount: Int
        if model.findCount() == 0 {
            classCount = 1
        }
        else {
            classCount = model.findCount()
        }
        print(classCount)
        print(model.findCount())
        let newPoints = (model.findTotalPoints() * Double(model.findTotalHours()) / Double(classCount))
        print("newPoints: \(newPoints)")
        gradesPointValue = gradesPointValue + newPoints
        let projectedValue = gradesPointValue/Double(totalHours)
        print("projectedValue: \(projectedValue)")
        projectedGPAValueLabel.text = String.localizedStringWithFormat("%.2f", projectedValue)
        print("gradesPointValue After: \(gradesPointValue)")
        print("totalHours After: \(totalHours)")
        print("*******************************************")
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddClassViewController {
            destination.delegate = self
        }else if let destination = segue.destination as? SetCurrentInfoViewController {
            destination.delegate = self
        }
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ClassListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClassInfoCell",
                                                     for: indexPath) as? ClassListTableViewCell,
            let classInfo = model.findClass(atIndex: indexPath.row)
            else { return UITableViewCell() }
        
        cell.decorate(with: classInfo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            model.removeCell(index: indexPath.row)
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print("Row: \(row)")
        
        
    
    }
}

extension ClassListViewController: AddClassViewControllerDelegate {
    func save(classInfo: ClassInfo) {
        model.save(classInfo: classInfo)
    }
}

extension ClassListViewController: SetCurrentInfoViewControllerDelegate {
    func updateHoursAndGPA(hours: Int, GPA: Double) {
        currentGPAValueLabel.text = "\(GPA)"
        currentHoursValueLabel.text = "\(hours)"
    }
}


extension ClassListViewController: ClassListModelDelegate {
    func dataRefreshed() {
        self.tableView.reloadData()
    }
}


