//
//  ClassListTableViewCell.swift
//  gpaCalculator
//
//  Created by cody riewerts on 7/31/17.
//  Copyright © 2017 cody riewerts. All rights reserved.
//

import UIKit

class ClassListTableViewCell: UITableViewCell {
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var hoursValueLabel: UILabel!
    @IBOutlet weak var gradeValueLabel: UILabel!
    @IBOutlet weak var retakeLabel: UILabel!

    
    func decorate(with classInfo: ClassInfo) {
        classNameLabel.text = classInfo.name
        hoursValueLabel.text = "\(classInfo.hours)"
        gradeValueLabel.text = classInfo.grade
        retakeLabel.text = "Retake: \(classInfo.retake)"
        
        classNameLabel.textColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        hoursLabel.textColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        gradeLabel.textColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        self.backgroundColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        hoursValueLabel.textColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        gradeValueLabel.textColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
    }

}
