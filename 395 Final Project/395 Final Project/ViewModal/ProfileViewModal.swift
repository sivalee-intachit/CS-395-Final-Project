//
//  ProfileViewModal.swift
//  395 Final Project
//
//  Created by Justin Vu on 10/26/24.
//

import SwiftUI
import PhotosUI
import Foundation

class ProfileViewModal: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    @Published var profileImage: Image?
    
    func loadImage() async throws {
        guard let item = selectedItem else {return}
        guard let imageData = try await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: imageData) else {return}
        
        self.profileImage = Image(uiImage: uiImage)
    }
}
