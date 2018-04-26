//
//  ViewController.swift
//  gpaCalculator
//
//  Created by cody riewerts on 7/31/17.
//  Copyright © 2017 cody riewerts. All rights reserved.
//

import UIKit

protocol AddClassViewControllerDelegate: class {
    func save(classInfo: ClassInfo)
}

class AddClassViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: AddClassViewControllerDelegate?
    
    @IBOutlet private weak var classNameLabel: UILabel!
    @IBOutlet private weak var classNameTextField: UITextField!
    @IBOutlet private weak var hoursLabel: UILabel!
    @IBOutlet private weak var hoursTextField: UITextField!
    @IBOutlet private weak var gradeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet private weak var retakeLabel: UILabel!
    @IBOutlet weak var retakeSwitch: UISwitch!
    
    @IBOutlet weak var stepperLabel: UIStepper!
    
    @IBOutlet weak var previousGradeResultLabel: UILabel!
    @IBOutlet weak var previousGradeLabel: UILabel!
    @IBOutlet weak var addClassButton: UIButton!
    
    
    let gradeOptions: [String] = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F", "FN"]
    var selectedGrade: String = "A"
    var previousSelectedGrade: String = "A"
    
    let gradeToWeightDictionary: [String: Double] = [
        "A":4.0,
        "A-":3.7,
        "B+":3.3,
        "B":3.0,
        "B-":2.7,
        "C+":2.3,
        "C":2.0,
        "C-":1.7,
        "D+":1.3,
        "D":1.0,
        "D-":0.7,
        "F":0.0,
        "FN":0.0
    ]
    
    let stepperChoiceToGradeDictionary: [Int: String] = [
        6:"C-",
        5:"D+",
        4:"D",
        3:"D-",
        2:"F",
        1:"FN"
    ]

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        classNameLabel.textColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        hoursLabel.textColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        gradeLabel.textColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        retakeLabel.textColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        classNameTextField.backgroundColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        hoursTextField.backgroundColor = UIColor(red: 0.6, green: 0.12, blue: 0.2, alpha: 1.0)
        classNameTextField.textColor = UIColor.white
        hoursTextField.textColor = UIColor.white
        
        
        retakeSwitch.tintColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        retakeSwitch.onTintColor = UIColor(red: 0.92, green: 0.67, blue: 0.0, alpha: 1.0)
        
        hoursTextField.text = "3"
        retakeSwitch.isOn = false
        
        previousGradeLabel.isHidden = true
        previousGradeResultLabel.isHidden = true
        stepperLabel.isHidden = true

        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedBackground(_:)))
        view.addGestureRecognizer(tap)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedBackground(_ sender: UITapGestureRecognizer) {
        classNameTextField.resignFirstResponder()
        hoursTextField.resignFirstResponder()
    }
    
    
    //********************************************************************
    //new class picker info
    //********************************************************************
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradeOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: gradeOptions[row], attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGrade = gradeOptions[row]
    }

    
    
    //********************************************************************
    //Retake Switch Pressed
    //********************************************************************

    
    @IBAction func retakeSwitchPressed(_ sender: UISwitch) {
        
        if retakeSwitch.isOn == true {
            previousGradeLabel.isHidden = false
            previousGradeResultLabel.isHidden = false
            stepperLabel.isHidden = false
        }
        
        if retakeSwitch.isOn == false {
            previousGradeLabel.isHidden = true
            previousGradeResultLabel.isHidden = true
            stepperLabel.isHidden = true
        }
        
    }
    

    
    
    
    //********************************************************************
    //Stepper Value Changed
    //********************************************************************
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        previousSelectedGrade = stepperChoiceToGradeDictionary[Int(sender.value)]!
        previousGradeResultLabel.text = "\(previousSelectedGrade)"
    }
    
    
    
    
    
    //********************************************************************
    //Add a Class Button Pressed
    //********************************************************************
    
    @IBAction func addClassButtonPressed(_ sender: UIButton) {
        
        var name = classNameTextField.text ?? ""
        if name == "" {name = "UnNamed Class"}
        
        var hours = Int(hoursTextField.text!)
        
        let grade = selectedGrade
        
        var weight = gradeToWeightDictionary["\(selectedGrade)"]!
        
        var retake = "No"
        
        if retakeSwitch.isOn == true {
            hours = 0
            let previousWeight = gradeToWeightDictionary["\(previousSelectedGrade)"]!
            weight = weight - previousWeight
            retake = "Yes"
        }
        
        
        let newClass = ClassInfo(name: name, hours: hours!, grade: grade, weight: weight, retake: retake)
        
        
        delegate?.save(classInfo: newClass)
        let _ = navigationController?.popViewController(animated: true)
        
        print(newClass)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddClassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
