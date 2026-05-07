//
//  EmployeeViewModel.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//
// ViewModel/EmployeeViewModel.swift
import Foundation
import Combine
import SwiftData

@MainActor
class EmployeeViewModel: ObservableObject {
    @Published var employees: [Employee] = []
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchEmployees(for company: Company) {
        employees = company.employees
    }

    func addEmployee(name: String, position: String, company: Company) {
        let employee = Employee(name: name, position: position)
        employee.company = company
        company.employees.append(employee)
        context.insert(employee)
        try? context.save()      // <-- save first
        fetchEmployees(for: company)
    }

    func updateEmployee(employee: Employee, name: String,
                        position: String, company: Company) {
        employee.name = name
        employee.position = position
        try? context.save()      // <-- save first
        fetchEmployees(for: company)
    }

    func deleteEmployee(employee: Employee, company: Company) {
        context.delete(employee)
        try? context.save()      // <-- save first
        fetchEmployees(for: company)
    }
}
