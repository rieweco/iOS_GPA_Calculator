//
//  SetCurrentInfoViewController.swift
//  gpaCalculator
//
//  Created by cody riewerts on 8/2/17.
//  Copyright © 2017 cody riewerts. All rights reserved.
//

import UIKit

protocol SetCurrentInfoViewControllerDelegate: class {
    func updateHoursAndGPA(hours: Int, GPA: Double)
}

class SetCurrentInfoViewController: UIViewController {
    @IBOutlet weak var GPAValueTextField: UITextField!
    @IBOutlet weak var hoursValueTextField: UITextField!
    
    weak var delegate: SetCurrentInfoViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        GPAValueTextField.text = "3.2"
        hoursValueTextField.text = "60"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedBackground(_:)))
        view.addGestureRecognizer(tap)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedBackground(_ sender: UITapGestureRecognizer) {
        GPAValueTextField.resignFirstResponder()
        hoursValueTextField.resignFirstResponder()
    }

    
    
    @IBAction func SetButtonPressed(_ sender: UIButton) {
        
        let GPA = Double(GPAValueTextField.text!)
        let hours = Int(hoursValueTextField.text!)
        
        delegate?.updateHoursAndGPA(hours: hours!, GPA: GPA!)
        let _ = navigationController?.popViewController(animated: true)
        
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

extension SetCurrentInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

