//
//  EmployeeModel.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//

import SwiftData
import Foundation

@Model
class Employee {
    var name: String
    var position: String
    var company: Company?

    @Relationship(deleteRule: .nullify, inverse: \Project.personInCharge)
    var projects: [Project] = []

    init(name: String, position: String) {
        self.name = name
        self.position = position
    }
}
