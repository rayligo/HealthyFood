//
//  AIFruitClassificationView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 21/1/2025.
//
//

import Foundation
import SwiftUI
import CoreML
import Vision
import Combine
import UIKit
import PhotosUI

var Fruit: String = "Unknown"

enum ImageSource {
    case camera, photoLibrary
}
//Processing fruit classification model
class ModelView: ObservableObject {
    @Published var classificationLabel: String = "No results yet"
    @Published var fruitIdentifier: String? = nil
    //Structure the fruits in the picture
    func classify(image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            classificationLabel = "Error: Could not convert UIImage to CIImage"
            return
        }

        let configuration = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: FruitClassification(configuration: configuration).model) else {
            classificationLabel = "Error: Could not create VNCoreMLModel"
            return
        }

        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            DispatchQueue.main.async {
                if let results = request.results as? [VNClassificationObservation], let firstResult = results.first {
                    self?.fruitIdentifier = firstResult.identifier
                    Fruit = "\(firstResult.identifier)"
                } else {
                    self?.classificationLabel = "Classification failed: No results."
                }
            }
        }

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    self.classificationLabel = "Error performing handler: \(error.localizedDescription)"
                }
            }
        }
    }
}
//Image selector structure
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType = .camera
    var completion: (UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = sourceType
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
                parent.completion(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct AIFruitClassificationView: View {
    @StateObject private var modelView = ModelView()
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var imageSource: ImageSource = .photoLibrary
    @State private var navigateToNutritionView = false
    @State private var isImageSubmitted = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8
                                )
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: geometry.size.height * 0.3)
                            .overlay(
                                Text("Select or Take Photo an image")
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    NavigationLink(
                        destination: FruitNutritionView(fruit: modelView.fruitIdentifier ?? ""),
                        isActive: $navigateToNutritionView
                    ) {
                        EmptyView()
                    }

                    Button(action: {
                        if let selectedImage = selectedImage {
                            modelView.classify(image: selectedImage)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                navigateToNutritionView = true
                            }
                        }
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                    //Button to select or capture an image
                    //Display according to device orientation
                    if horizontalSizeClass == .compact {
                        VStack(spacing: 20) {
                            Button(action: {
                                checkPhotoLibraryPermission {
                                    imageSource = .photoLibrary
                                    isImagePickerPresented = true
                                }
                            }) {
                                Text("Choose Image")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                checkCameraPermission {
                                    imageSource = .camera
                                    isImagePickerPresented = true
                                }
                            }) {
                                Text("Take Photo")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                    } else {
                        HStack(spacing: 20) {
                            Button(action: {
                                checkPhotoLibraryPermission {
                                    imageSource = .photoLibrary
                                    isImagePickerPresented = true
                                }
                            }) {
                                Text("Choose Image")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                checkCameraPermission {
                                    imageSource = .camera
                                    isImagePickerPresented = true
                                }
                            }) {
                                Text("Capture Image")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.bottom, horizontalSizeClass == .compact ? 10 : max(30, geometry.safeAreaInsets.bottom))
                .ignoresSafeArea(.keyboard)
                .padding()
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, sourceType: imageSource == .camera ? .camera : .photoLibrary) { newImage in
                        selectedImage = newImage
                        isImageSubmitted = false
                    }
                }
            }
        }
        .navigationBarTitle("Fruit Classification", displayMode: .inline)
    }
    
    //Check photo library permissions
    private func checkPhotoLibraryPermission(completion: @escaping () -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized, .limited:
            completion()
        case .denied, .restricted:
            print("No access to photo library")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized || status == .limited {
                    completion()
                } else {
                    print("Access to photo library denied")
                }
            }
        @unknown default:
            fatalError("Unknown authorization status")
        }
    }
    
    //Check camera permissions
    private func checkCameraPermission(completion: @escaping () -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion()
        case .denied, .restricted:
            print("No access to camera")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    completion()
                } else {
                    print("Access to camera denied")
                }
            }
        @unknown default:
            fatalError("Unknown authorization status")
        }
    }
}

struct AIFruitClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        AIFruitClassificationView()
        .previewDevice("iPhone 13")
    }
}
