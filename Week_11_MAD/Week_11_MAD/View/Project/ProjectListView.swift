// View/Project/ProjectListView.swift
import SwiftUI

struct ProjectListView: View {
    @EnvironmentObject var projectVM: ProjectViewModel
    var company: Company

    @State private var showAddSheet = false
    @State private var projectToEdit: Project? = nil

    var body: some View {
        List(projectVM.projects) { project in
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(project.name)
                        .font(.headline)
                    Spacer()
                    Text(project.isActive ? "Active" : "Completed")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(project.isActive ? Color.blue.opacity(0.15) : Color.gray.opacity(0.15))
                        .foregroundStyle(project.isActive ? .blue : .gray)
                        .clipShape(Capsule())
                }

                if !project.desc.isEmpty {
                    Text(project.desc)          // ← now uses desc, not name twice
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                HStack {
                    Image(systemName: "calendar")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(project.startDate.formatted(date: .abbreviated, time: .omitted)) – \(project.endDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Label(
                    project.personInCharge?.name ?? "Unassigned",
                    systemImage: project.personInCharge != nil ? "person.fill" : "person.fill.questionmark"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
            .contextMenu {
                Button { projectToEdit = project } label: {
                    Label("Update", systemImage: "pencil")
                }
                Button(role: .destructive) {
                    projectVM.deleteProject(project: project, company: company)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .navigationTitle("Projects")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showAddSheet = true } label: { Image(systemName: "plus") }
            }
        }
        .onAppear { projectVM.fetchProjects(for: company) }
        .sheet(isPresented: $showAddSheet) {
            ProjectFormView(company: company)
                .environmentObject(projectVM)
        }
        .sheet(item: $projectToEdit) { project in
            ProjectFormView(company: company, project: project)
                .environmentObject(projectVM)
        }
    }
}
