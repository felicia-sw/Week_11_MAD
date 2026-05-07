//
//  CompanyViewModel.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//
// ViewModel/CompanyViewModel.swift
import Foundation
import Combine
import SwiftData

@MainActor
class CompanyViewModel: ObservableObject {
    @Published var companies: [Company] = []
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchCompanies()
    }

    func fetchCompanies() {
        let descriptor = FetchDescriptor<Company>()
        companies = (try? context.fetch(descriptor)) ?? []
    }

    func addCompany(name: String, location: String) {
        let company = Company(name: name, location: location)
        context.insert(company)
        try? context.save()      // <-- save first
        fetchCompanies()
    }

    func updateCompany(company: Company, name: String, location: String) {
        company.name = name
        company.location = location
        try? context.save()      // <-- save first
        fetchCompanies()
    }

    func deleteCompany(company: Company) {
        context.delete(company)
        try? context.save()      // <-- save first
        fetchCompanies()
    }
}
