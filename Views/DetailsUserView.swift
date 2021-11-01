//
//  DetailsUserView.swift
//  contact
//
//  Created by jose juan alcantara rincon on 31/10/21.
//

import SwiftUI
import CoreData

struct DetailsUserView: View {
    var contact: Contact
    let coreDM: CoreDataManager
    @Binding var rootActive: Bool
    @Binding var contacts: [Contact]
    @State private var name = ""
    @State private var phone = ""
   
    var body: some View {
        VStack {
            Spacer()
            Text(contact.name ?? "User")
                .font(.largeTitle)
                .bold()
            Spacer()
            if (contact.img == nil || contact.img?.count == 0){
                Image(systemName: "person.fill")
                    .resizable()
                    .padding(40)
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .background(Color.gray)
                    .clipShape(Circle())
            }else {
                Image(uiImage: UIImage(data: contact.img!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            }
            Spacer()
            TextField(contact.name ?? "", text: $name)
                .font(.custom("Arial", size: 20))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 350)
            TextField(contact.phone ?? "", text: $phone)
                .font(.custom("Arial", size: 20))
                .keyboardType(.phonePad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 350)
            Spacer()
            HStack {
                Button(action: {
                    if !name.isEmpty{
                        contact.name = name
                        coreDM.updateContact()
                    }
                    if !phone.isEmpty {
                        contact.phone = phone
                        coreDM.updateContact()
                    }
                    contacts = coreDM.getAllContacts()
                    rootActive = false
                }) {
                    Text("Save")
                        .padding()
                        .padding(.horizontal, 10)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button(action: {
                    rootActive = false
                }) {
                    Text("Cancel")
                        .padding()
                        .padding(.horizontal, 3)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct DetailsUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsUserView(contact: Contact(), coreDM: CoreDataManager(), rootActive: .constant(true), contacts: .constant([Contact]()))
    }
}
