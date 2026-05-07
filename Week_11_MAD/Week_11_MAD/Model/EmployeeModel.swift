//
//  EmployeeModel.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//

// Model/EmployeeModel.swift
import SwiftData
import Foundation

@Model
class Employee {
    var name: String
    var position: String
    var company: Company?

    // ← No @Relationship here — Project.personInCharge already owns this side
    var projects: [Project] = []

    init(name: String, position: String) {
        self.name = name
        self.position = position
    }
}
