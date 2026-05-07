//
//  CompanyFormView.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//

// View/Company/CompanyFormView.swift
import SwiftUI

struct CompanyFormView: View {
    @EnvironmentObject var companyVM: CompanyViewModel
    @Environment(\.dismiss) private var dismiss

    var company: Company? = nil

    @State private var name = ""
    @State private var location = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Company Information") {
                    TextField("Company Name", text: $name)
                    TextField("Company Address", text: $location)
                }
            }
            .navigationTitle(company == nil ? "New Company" : "Edit Company")
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
                    .disabled(name.isEmpty || location.isEmpty)
                }
            }
            .onAppear {
                if let company {
                    name = company.name
                    location = company.location
                }
            }
        }
    }

    func save() {
        if let company {
            companyVM.updateCompany(company: company, name: name, location: location)
        } else {
            companyVM.addCompany(name: name, location: location)
        }
        dismiss()
    }
}
