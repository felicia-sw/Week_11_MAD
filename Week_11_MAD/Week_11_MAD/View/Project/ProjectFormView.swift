// View/Project/ProjectFormView.swift
import SwiftUI

struct ProjectFormView: View {
    @EnvironmentObject var projectVM: ProjectViewModel
    @Environment(\.dismiss) private var dismiss

    var company: Company
    var project: Project? = nil

    @State private var name = ""
    @State private var desc = ""           // ← added
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedEmployee: Employee? = nil

    var body: some View {
        NavigationStack {
            Form {
                Section("Project Information") {
                    TextField("Project Name", text: $name)
                    TextField("Enter project description...", text: $desc, axis: .vertical)  // ← added
                        .lineLimit(3...6)
                }

                Section("Timeline") {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }

                Section("Person In Charge") {
                    Picker("Select Employee", selection: $selectedEmployee) {
                        Text("None").tag(Optional<Employee>.none)
                        ForEach(company.employees) { emp in
                            Text(emp.name).tag(Optional<Employee>.some(emp))
                        }
                    }
                }
            }
            .navigationTitle(project == nil ? "New Project" : "Edit Project")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: { Image(systemName: "xmark") }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button { save() } label: { Image(systemName: "checkmark") }
                        .disabled(name.isEmpty)
                }
            }
            .onAppear {
                if let project {
                    name = project.name
                    desc = project.desc
                    startDate = project.startDate
                    endDate = project.endDate
                    selectedEmployee = project.personInCharge
                }
            }
        }
    }

    func save() {
        if let project {
            projectVM.updateProject(
                project: project,
                name: name,
                desc: desc,
                startDate: startDate,
                endDate: endDate,
                personInCharge: selectedEmployee,
                company: company
            )
        } else {
            projectVM.addProject(
                name: name,
                desc: desc,
                startDate: startDate,
                endDate: endDate,
                personInCharge: selectedEmployee,
                company: company
            )
        }
        dismiss()
    }
}
