//
//  ImageVM.swift
//  YeryLibrary
//
//  Created by Yery Castro on 13/3/24.
//

import SwiftUI

@Observable
final class ImageVM {
    var image: UIImage?
    
    let interactor: ImageInteractor
    
    init(interactor: ImageInteractor = ImageManager()) {
        self.interactor = interactor
    }
    
    func getImage(url: URL?) throws {
        guard let url else { return }
        let imageURL = URL.cachesDirectory.appending(path: url.lastPathComponent)
        if FileManager.default.fileExists(atPath: imageURL.path()) {
            let data = try Data(contentsOf: imageURL)
            image = UIImage(data: data)
        } else {
            Task {
                let image = try await interactor.getImage(url: url)
                await MainActor.run {
                    self.image = image
                }
            }
        }
    }
}
