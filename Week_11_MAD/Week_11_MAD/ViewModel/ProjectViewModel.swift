// ViewModel/ProjectViewModel.swift
import Foundation
import Combine
import SwiftData

@MainActor
class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchProjects(for company: Company) {
        projects = company.projects.sorted { $0.endDate < $1.endDate }
    }

    func addProject(name: String, desc: String, startDate: Date, endDate: Date,
                    personInCharge: Employee?, company: Company) {
        let project = Project(name: name, desc: desc, startDate: startDate, endDate: endDate)
        project.personInCharge = personInCharge
        project.company = company
        company.projects.append(project)
        context.insert(project)
        try? context.save()
        fetchProjects(for: company)
    }

    func updateProject(project: Project, name: String, desc: String, startDate: Date,
                       endDate: Date, personInCharge: Employee?, company: Company) {
        project.name = name
        project.desc = desc
        project.startDate = startDate
        project.endDate = endDate
        project.personInCharge = personInCharge
        try? context.save()
        fetchProjects(for: company)
    }

    func deleteProject(project: Project, company: Company) {
        context.delete(project)
        try? context.save()
        fetchProjects(for: company)
    }
}
