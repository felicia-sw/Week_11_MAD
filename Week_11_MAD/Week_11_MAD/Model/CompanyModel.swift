//
//  CompanyModel.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//

// Model/CompanyModel.swift
import SwiftData
import Foundation

@Model
class Company {
    var name: String
    var location: String

    @Relationship(deleteRule: .cascade, inverse: \Project.company)
    var projects: [Project] = []

    @Relationship(deleteRule: .cascade, inverse: \Employee.company)
    var employees: [Employee] = []

    var employeeCount: Int { employees.count }

    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
