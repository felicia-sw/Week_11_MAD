//
//  EmployeeFormView.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//
// View/Employee/EmployeeFormView.swift
import SwiftUI

struct EmployeeFormView: View {
    @EnvironmentObject var employeeVM: EmployeeViewModel
    @Environment(\.dismiss) private var dismiss

    var company: Company
    var employee: Employee? = nil

    @State private var name = ""
    @State private var position = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Employee Information") {
                    TextField("Name", text: $name)
                    TextField("Role", text: $position)
                }
            }
            .navigationTitle(employee == nil ? "New Employee" : "Edit Employee")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        save()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(name.isEmpty || position.isEmpty)
                }
            }
            .onAppear {
                if let employee {
                    name = employee.name
                    position = employee.position
                }
            }
        }
    }

    func save() {
        if let employee {
            employeeVM.updateEmployee(
                employee: employee,
                name: name,
                position: position,
                company: company
            )
        } else {
            employeeVM.addEmployee(
                name: name,
                position: position,
                company: company
            )
        }
        dismiss()
    }
}
