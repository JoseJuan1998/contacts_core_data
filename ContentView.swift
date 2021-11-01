//
//  ContentView.swift
//  contact
//
//  Created by jose juan alcantara rincon on 31/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var coreDM: CoreDataManager = CoreDataManager()
    @State private var contacts: [Contact] = [Contact]()
    @State private var addActive: Bool = false
    @State var refresh: Bool = false
    var body: some View {
        NavigationView {
            ListView(contacts: $contacts, detailsActive: $refresh, coreDM: $coreDM)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        addActive = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $addActive, content: {
                        NewUserView(coreDM: CoreDataManager(), rootActive: $addActive, contacts: $contacts)
                    })
                }
            }
            .navigationBarTitle("Contacts")
            .refreshable {
                contacts = coreDM.getAllContacts()
            }
            .onAppear {
                contacts = coreDM.getAllContacts()
            }
            .accentColor(!refresh ? .blue : .white)        }
        .navigationBarTitle("Contacts")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
