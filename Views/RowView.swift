//
//  RowView.swift
//  contact
//
//  Created by jose juan alcantara rincon on 31/10/21.
//

import SwiftUI
import CoreData

struct RowView: View {
    var contact: Contact
    var body: some View {
        HStack {
            
            if (contact.img == nil || contact.img?.count == 0){
                Text(contact.name![..<((contact.name?.index(contact.name!.startIndex, offsetBy: 1))!)] ?? "" )
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.gray)
                    .font(.custom("Arial", size: 25))
                    .clipShape(Circle())
            }else {
                Image(uiImage: UIImage(data: contact.img!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading) {
                Text(contact.name ?? "")
                    .font(.custom("Arial", size: 20))
                    .foregroundColor(.blue)
                Text(contact.phone ?? "")
                    .font(.custom("Arial", size: 15))
                    .foregroundColor(.blue)
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(contact: Contact())
    }
}
