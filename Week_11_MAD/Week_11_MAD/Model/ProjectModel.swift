//
//  ProjectModel.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//

// Model/ProjectModel.swift
import SwiftData
import Foundation

@Model
class Project {
    var name: String
    var desc: String          // ← added description field
    var startDate: Date
    var endDate: Date
    var company: Company?

//    @Relationship(deleteRule: .nullify)
    var personInCharge: Employee?

    var isActive: Bool { endDate > Date.now }

    init(name: String, desc: String = "", startDate: Date, endDate: Date) {
        self.name = name
        self.desc = desc
        self.startDate = startDate
        self.endDate = endDate
    }
}
