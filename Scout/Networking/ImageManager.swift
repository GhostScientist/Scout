//
//  ImageManager.swift
//  Scout
//
//  Created by Dakota Kim on 9/29/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import Foundation
import Firebase

class ImageManager {
    
    // TODO: - Implement proper Storage algorithm.
    
    let storage = Storage.storage()
    let storageDummyReference = Storage.storage().reference().child("dummy.jpg")
    
    func getURLFor(_ reference: StorageReference) {
        reference.downloadURL { (url, error) in
            print("url is \(url)")
            guard let downloadURL = url else { return }
            Networker.shared.updateDataFor(downloadURL.absoluteString)
        }
    }
    
    func upload(_ data: Data, completion: @escaping ((String) -> Void)) {
        var imageURL = ""
        let _ = storageDummyReference.putData(data, metadata: nil) { (metadata, error) in
            self.storageDummyReference.downloadURL(completion: { (storedURL, error) in
                if let downloadURL = storedURL?.absoluteString {
                    imageURL = downloadURL
                    print(imageURL)
                    completion(downloadURL)
                }
            })
        }
    }
}
