// View/Company/CompanyDetailView.swift
import SwiftUI
import SwiftData

struct CompanyDetailView: View {
    var company: Company
    @Environment(\.modelContext) private var context

    // ← Use @StateObject so the VM is created ONCE, not on every re-render
    @StateObject private var employeeVM: EmployeeViewModel
    @StateObject private var projectVM: ProjectViewModel

    init(company: Company, context: ModelContext) {
        self.company = company
        _employeeVM = StateObject(wrappedValue: EmployeeViewModel(context: context))
        _projectVM = StateObject(wrappedValue: ProjectViewModel(context: context))
    }

    var body: some View {
        List {
            NavigationLink(destination:
                EmployeeListView(company: company)
                    .environmentObject(employeeVM)
            ) {
                Label {
                    VStack(alignment: .leading) {
                        Text("Employees")
                            .font(.headline)
                        Text("\(company.employeeCount) items")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                } icon: {
                    Image(systemName: "person.3.fill")
                        .foregroundStyle(.blue)
                }
            }

            NavigationLink(destination:
                ProjectListView(company: company)
                    .environmentObject(projectVM)
            ) {
                Label {
                    VStack(alignment: .leading) {
                        Text("Projects")
                            .font(.headline)
                        Text("\(company.projects.count) items")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                } icon: {
                    Image(systemName: "folder.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
        .navigationTitle(company.name)
    }
}
