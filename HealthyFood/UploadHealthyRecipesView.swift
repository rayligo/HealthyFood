//
//  UploadHealthyRecipesView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 23/1/2025.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import PhotosUI



//Close the keyboard function
extension UIApplication {
    func endEditing(_ force: Bool) {
        guard let window = connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return }
        
        window.endEditing(force)
    }
}

struct UploadHealthyRecipesView: View {
    @StateObject private var viewModel = ViewModel()
    @State var AddName = ""
    @State var AddImage: UIImage? = nil
    @State var AddMaterial = ""
    @State var AddPractice = ""
    @State var showingImagePicker = false
    @State var showingCamera = false
    @State var errorMessage = ""

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        //Enter a recipe name
                        TextField("Name", text: $AddName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        if let image = AddImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 200)
                                .cornerRadius(10)
                                .padding()
                        }
                        
                        HStack {
                            //Select an image from your photo library
                            Button(action: {
                                showingImagePicker = true
                            }) {
                                Text(AddImage == nil ? "Select Image" : "Image Selected")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .padding()
                            }
                            .sheet(isPresented: $showingImagePicker) {
                                CustomImagePicker(image: $AddImage)
                            }
                            
                            Button(action: {
                                showingCamera = true
                            }) {
                                Text("Take Photo")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .padding()
                            }
                            .sheet(isPresented: $showingCamera) {
                                CameraPicker(image: $AddImage)
                            }
                        }


                        
                        //Enter the text label of the material
                        VStack(alignment: .leading) {
                            Text("Material")
                                .font(.headline)
                                .foregroundColor(.gray)
                            TextEditor(text: $AddMaterial)
                                .frame(height: 100)
                                .cornerRadius(10)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        
                        VStack(alignment: .leading) {
                            //Enter a text label for the food recipe
                            Text("Practice")
                                .font(.headline)
                                .foregroundColor(.gray)
                            TextEditor(text: $AddPractice)
                                .frame(height: 100)
                                .cornerRadius(10)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        //Add recipe button
                        Button(action: {
                            if !AddName.isEmpty && AddImage != nil && !AddMaterial.isEmpty && !AddPractice.isEmpty {
                                viewModel.addDate(name: AddName, image: AddImage!, material: AddMaterial.replacingOccurrences(of: "\n", with: "\\n"), practice: AddPractice.replacingOccurrences(of: "\n", with: "\\n"))
                                AddName = ""
                                AddImage = nil
                                AddMaterial = ""
                                AddPractice = ""
                                errorMessage = ""
                                UIApplication.shared.endEditing(true)
                            } else {
                                errorMessage = "Please fill all fields and select an image."
                            }
                        }) {
                            Text("Add Recipe")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding()
                        }

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .padding()
                }
                .onTapGesture {
                    UIApplication.shared.endEditing(true)
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
//Image Selector
struct CustomImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: CustomImagePicker
        
        init(_ parent: CustomImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}

//Camera Selector
struct CameraPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPicker
        
        init(_ parent: CameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            parent.image = info[.originalImage] as? UIImage
        }
    }
}

struct UploadHealthyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        UploadHealthyRecipesView()
    }
}
