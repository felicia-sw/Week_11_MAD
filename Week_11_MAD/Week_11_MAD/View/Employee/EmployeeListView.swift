//
//  EmployeeListView.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//
// View/Employee/EmployeeListView.swift
import SwiftUI

struct EmployeeListView: View {
    @EnvironmentObject var employeeVM: EmployeeViewModel
    var company: Company

    @State private var showAddSheet = false
    @State private var employeeToEdit: Employee? = nil

    var body: some View {
        List(employeeVM.employees) { employee in
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.15))
                        .frame(width: 44, height: 44)
                    Text(initials(for: employee.name))
                        .font(.headline)
                        .foregroundStyle(.blue)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(employee.name)
                        .font(.headline)
                    Text(employee.position)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("\(employee.projects.count)")
                        .font(.headline)
                    Text("Projects")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
            .contextMenu {
                Button {
                    employeeToEdit = employee
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                Button(role: .destructive) {
                    employeeVM.deleteEmployee(employee: employee, company: company)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .navigationTitle("Employees")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            employeeVM.fetchEmployees(for: company)
        }
        .sheet(isPresented: $showAddSheet) {
            EmployeeFormView(company: company)
                .environmentObject(employeeVM)
        }
        .sheet(item: $employeeToEdit) { employee in
            EmployeeFormView(company: company, employee: employee)
                .environmentObject(employeeVM)
        }
    }

    func initials(for name: String) -> String {
        let parts = name.split(separator: " ")
        let letters = parts.prefix(2).compactMap { $0.first }
        return letters.map { String($0) }.joined().uppercased()
    }
}
