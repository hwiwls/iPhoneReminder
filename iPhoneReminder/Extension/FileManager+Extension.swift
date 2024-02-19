//
//  FileManager+Extension.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/19/24.
//

import UIKit

extension UIViewController {
    
    // 이미지 불러오기
    func loadImageToDocument(filename: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    // 이미지 저장
    func saveImageToDocument(image: UIImage, filename: String) {    
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
}
