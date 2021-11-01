//
//  ListView.swift
//  contact
//
//  Created by jose juan alcantara rincon on 31/10/21.
//

import SwiftUI
import CoreData

struct ListView: View {
    @Binding var contacts: [Contact]
    @Binding var detailsActive: Bool
    @Binding var coreDM: CoreDataManager
    private func loadContacts() {
        contacts = coreDM.getAllContacts()
    }
    var body: some View {
        List {
            ForEach(contacts, id: \.self) { contact in
                NavigationLink(
                    destination: DetailsUserView(contact: contact, coreDM: coreDM, rootActive: $detailsActive, contacts: $contacts),
                    isActive: $detailsActive) {
                        RowView(contact: contact)
                    }
            }
            .onDelete(perform: { indexSet in
                indexSet.forEach{ index in
                    let contact = contacts[index]
                    coreDM.deleteContact(contact: contact)
                    loadContacts()
                }
            })
        }
        .refreshable {
            loadContacts()
        }
        .listStyle(PlainListStyle())
        .onAppear {
            loadContacts()
        }
        .accentColor(!detailsActive ? .white : .black)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(contacts: .constant([Contact]()), detailsActive: .constant(false), coreDM: .constant(CoreDataManager()))
    }
}
