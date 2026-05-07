// View/Company/CompanyListView.swift
import SwiftUI
import SwiftData

struct CompanyListView: View {
    @EnvironmentObject var companyVM: CompanyViewModel
    @Environment(\.modelContext) private var context   // ← add this
    @State private var showAddSheet = false
    @State private var companyToEdit: Company? = nil

    var body: some View {
        NavigationStack {
            List(companyVM.companies) { company in
                NavigationLink(destination: CompanyDetailView(company: company, context: context)) {  // ← pass context
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(company.name)
                                .font(.headline)
                            Text(company.location)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("Active Projects: \(company.projects.filter { $0.isActive }.count)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Label("\(company.employeeCount)", systemImage: "person.fill")
                            .font(.caption)
                    }
                    .padding(.vertical, 4)
                }
                .contextMenu {
                    Button {
                        companyToEdit = company
                    } label: {
                        Label("Update", systemImage: "pencil")
                    }
                    Button(role: .destructive) {
                        companyVM.deleteCompany(company: company)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Companies")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showAddSheet = true } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                CompanyFormView()
                    .environmentObject(companyVM)
            }
            .sheet(item: $companyToEdit) { company in
                CompanyFormView(company: company)
                    .environmentObject(companyVM)
            }
        }
    }
}
