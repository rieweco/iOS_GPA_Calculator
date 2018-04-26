//
//  ClassModel.swift
//  gpaCalculator
//
//  Created by cody riewerts on 7/31/17.
//  Copyright © 2017 cody riewerts. All rights reserved.
//

import Foundation

protocol ClassListModelDelegate: class {
    func dataRefreshed()
}

protocol ClassListModelInterface {
    weak var delegate: ClassListModelDelegate? { get set }
    var count: Int { get }
    func findClass(atIndex index: Int) -> ClassInfo?
    func save(classInfo: ClassInfo)
    func findTotalHours() -> Int
    func findTotalPoints() -> Double
    func findCount() -> Int
    func updateHoursAndGPA(hours: Int, GPA: Double)
    func removeCell(index: Int)
}

class ClassListModel: ClassListModelInterface {
    weak var delegate: ClassListModelDelegate?
    
    private var classes = [ClassInfo]()
    
    init() {
        delegate?.dataRefreshed()
    }
    
    var count: Int {
        return classes.count
    }
    
    func findCount() -> Int {
        let totalCount = classes.count
        var retakeCount = 0
        for eachClass in classes {
            if eachClass.retake == "Yes" {
                retakeCount = retakeCount + 1
            }
        }
        return totalCount - retakeCount
    }
    
    func updateHoursAndGPA(hours: Int, GPA: Double) {
        delegate?.dataRefreshed()
    }
    
    
    func findClass(atIndex index: Int) -> ClassInfo? {
        return classes[index]
    }
    
    func save(classInfo: ClassInfo){
        classes.append(classInfo)
        
        delegate?.dataRefreshed()
    }
    
    func removeCell(index: Int) {
        classes.remove(at: index)
        delegate?.dataRefreshed()
    }
    
    func findTotalHours() -> Int {
        var totalHours = 0
        for eachClass in classes {
            totalHours += eachClass.hours
        }
        return totalHours
    }
    
    func findTotalPoints() -> Double {
        var totalPoints = 0.0
        for eachClass in classes {
            totalPoints += eachClass.weight
        }
        return totalPoints
    }
    
}
