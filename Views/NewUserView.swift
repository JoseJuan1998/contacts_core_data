//
//  NewUserView.swift
//  contact
//
//  Created by jose juan alcantara rincon on 31/10/21.
//

import SwiftUI
import CoreData

struct NewUserView: View {
    let coreDM: CoreDataManager
    @Binding var rootActive: Bool
    @Binding var contacts: [Contact]
    @State private var name = ""
    @State private var phone = ""
    @State private var image: Data = .init(count: 0)
    @State private var showImage: Bool = false
   
    var body: some View {
        VStack {
            Spacer()
            Text("New User")
                .font(.largeTitle)
                .bold()
            Spacer()
            if image.count != 0 {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .onTapGesture {
                        showImage = true
                    }
                    .sheet(isPresented: $showImage, content: {
                        ImagePicker(images: $image, show: $showImage)
                    })
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .padding(40)
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .onTapGesture {
                        showImage = true
                    }
                    .sheet(isPresented: $showImage, content: {
                        ImagePicker(images: $image, show: $showImage)
                    })
            }
            
            Spacer()
            TextField("Name", text: $name)
                .font(.custom("Arial", size: 20))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 350)
            TextField("Phone number", text: $phone)
                .font(.custom("Arial", size: 20))
                .keyboardType(.phonePad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 350)
            Spacer()
            HStack {
                Button(action: {
                    coreDM.saveContact(name: name, phone: phone, image: image)
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

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView(coreDM: CoreDataManager(), rootActive: .constant(true), contacts: .constant([Contact]()))
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: Data
    @Binding var show: Bool
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(img1: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let img0: ImagePicker
        
        init(img1: ImagePicker){
            img0 = img1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.img0.show.toggle()
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            
            let data = image.jpegData(compressionQuality: 0.50)
            
            self.img0.images = data!
            self.img0.show.toggle()
        }
    }
}
