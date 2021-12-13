//
//  DownloadManager.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 12.10.21.
//

import Foundation
import UIKit

protocol DownloadManagerProtocol {
    func fetchData(from url: String, completion: @escaping (Data?, Error?) -> ())
    func loadImage(for url: String, completion: @escaping (UIImage?, Error?) -> ())
}

class DownloadManager: DownloadManagerProtocol {
    
    private let session = URLSession.shared
    
    func fetchData(from url: String, completion: @escaping (Data?, Error?) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(data, nil)
                }
            }
        }
        dataTask.resume()
    }
    
    func loadImage(for url: String, completion: @escaping (UIImage?, Error?) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        let dataTask = session.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error { completion(nil, error) }
                
                guard let data = data else { return }
                if let image = UIImage(data: data) {
                    completion(image, error)
                }
            }
        }
        dataTask.resume()
    }
}
