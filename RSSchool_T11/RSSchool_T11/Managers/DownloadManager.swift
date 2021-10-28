//
//  DownloadManager.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 12.10.21.
//

import Foundation
import UIKit

class DownloadManager {
    
    private let session = URLSession.shared
    
    private let queue = OperationQueue()
    private var operations = [String : Operation]()
    
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
        
        cancelDownloadingOperation(for: url)
        let operation = ImageDownloadOperation(with: url)
        operations[url] = operation
        operation.completion = { image, error in
            DispatchQueue.main.async {
                completion(image, error)
            }
        }
        queue.addOperation(operation)
    }
    
    func cancelDownloadingOperation(for url: String) {
        let operation = self.operations[url]
        operation?.cancel()
    }
}
