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

class ModelView: ObservableObject {
    @Published var classificationLabel: String = "No results yet"
    @Published var fruitIdentifier: String? = nil

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
                    self?.classificationLabel = "\(firstResult.identifier) (\(firstResult.confidence * 100)%)"
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
                            .frame(height: geometry.size.height * 0.3)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: geometry.size.height * 0.3)
                            .overlay(
                                Text("Select or capture an image")
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    if isImageSubmitted {
                        Text(modelView.classificationLabel)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        if let fruitIdentifier = modelView.fruitIdentifier {
                            NavigationLink(destination: FruitNutritionView(fruit: fruitIdentifier)) {
                                Text("Go to Fruit Nutrition")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .background(Color.orange)
                                    .cornerRadius(8)
                            }
                        }
                    } else {
                        Text("Submit an image to classify it")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                    }

                    Button(action: {
                        if let selectedImage = selectedImage {
                            modelView.classify(image: selectedImage)
                            isImageSubmitted = true
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
                                Text("Capture Image")
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
