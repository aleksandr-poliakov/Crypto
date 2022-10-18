//
//  LocalStorage.swift
//  CryptoWallet
//
//  Created by Aleksandr on 18.10.2022.
//

import UIKit

protocol LocalStore {
    func getImage(imageName: String, folderName: String) -> UIImage?
    func saveImage(image: UIImage, imageName: String, folderName: String)
}

final class LocalFileManager: LocalStore {
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. \(error)")
        }
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error create directory. \(folderName). \(error)")
            }
        }
        
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folder = getURLForFolder(folderName: folderName) else { return nil }
        
        return folder.appendingPathComponent(imageName + ".png")
    }
}
