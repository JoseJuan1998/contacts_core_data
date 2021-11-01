//
//  CoreDataManager.swift
//  contact
//
//  Created by jose juan alcantara rincon on 31/10/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Contact")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func updateContact() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
            
        }
    }
    
    func deleteContact(contact: Contact) {
        persistentContainer.viewContext.delete(contact)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func getAllContacts() -> [Contact] {
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveContact(name: String, phone: String, image: Data) {
        let contact = Contact(context: persistentContainer.viewContext)
        contact.name = name
        contact.phone = phone
        contact.img = image
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save contact \(error)")
        }
    }
}
