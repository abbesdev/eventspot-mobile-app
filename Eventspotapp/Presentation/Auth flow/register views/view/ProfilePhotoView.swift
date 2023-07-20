//
//  SetupAccountView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 13/7/2023.
//

import SwiftUI



struct ProfilePhotoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    
    
    var body: some View {
        NavigationView {
            
            VStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("barr") // Replace with your image name or URL
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18) // Adjust the size of the image
                            .foregroundColor(.blue) // Change the color of the image as desired
                            .padding(14)
                            .overlay(
                                Circle()
                                
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 0.5)
                            )
                            .padding(.horizontal)
                            .padding(.bottom,8)
                        Spacer()
                    }
                }
                Text("Add profile photo")
                    .font(
                        .system( size: 30)
                    )
                    .bold()
                    .padding(.horizontal)
                
                    .kerning(0.374)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text("Choose a suitable profile photo")
                    .font(.system( size: 18))
                    .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                    .padding(.top,1)
                    .padding(.bottom,10)
                
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal)
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2)
                                .cornerRadius(12)

                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30,height: 30)
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                Text("1 profile photo required")
                    .font(.system( size: 18))
                    .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                    .padding(.top,8)
                    .padding(.bottom,10)
                Spacer()
                
                HStack(alignment: .center, spacing: 0) {
                    Text("Finish setting up account")
                        .foregroundColor(.white)
                }
                
                .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                .cornerRadius(4)
                .padding()
                //                    .disabled(registrationViewModel.username.isEmpty || registrationViewModel.email.isEmpty || registrationViewModel.password.isEmpty)
                .onTapGesture {
                    //                        registrationViewModel.username = username
                    //                        registrationViewModel.email = email
                    //                        registrationViewModel.password = password
                    //
                    //                        registrationViewModel.register()
                    
                }
                
            }
            
        }
        
        
    }
    
    
    private func loadImage() {
        guard let selectedImage = selectedImage else { return }
        
        // Perform any necessary operations with the selected image
        // For example, you can save it to your app's data model or upload it to a server
        
        // Here, we'll simply print the image size
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            print("Selected image size: \(imageData.count) bytes")
        }
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No need to update the view controller
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct ProfilePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoView()
    }
}
