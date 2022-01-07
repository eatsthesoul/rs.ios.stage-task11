//
//  ImageDownloader.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 17.12.21.
//

import UIKit

protocol ImageServiceProtocol {
    func loadImage(for url: String, completion: @escaping (UIImage?, Error?) -> ())
}

class ImageService: ImageServiceProtocol {
    
    private let imageCache: NSCache<NSString, UIImage>
    
    init() {
        imageCache = NSCache<NSString, UIImage>()
        imageCache.totalCostLimit = 1024 * 1024 * 500 // 500 MBytes
    }
    
    func loadImage(for url: String, completion: @escaping (UIImage?, Error?) -> ()) {
        let key = NSString(string: url)
        
        if let image = imageCache.object(forKey: key) {
            completion(image, nil)
        }

        guard let url = URL(string: url) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else { return }
                self?.imageCache.setObject(image, forKey: key)
                completion(image, nil)
            }
        }
        dataTask.resume()
    }
}

