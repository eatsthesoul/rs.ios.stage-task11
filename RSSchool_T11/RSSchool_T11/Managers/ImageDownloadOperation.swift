//
//  ImageDownloadOperation.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 26.10.21.
//

import UIKit

class ImageDownloadOperation: Operation {
    
    var image: UIImage?
    var completion: ((UIImage?, Error?) -> ())?
    
    private let url: String
    
    init(with url: String) {
        self.url = url
        super.init()
    }
    
    override func main() {
        
        if isCancelled { return }
        
        guard let url = URL(string: url) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let err = error { self?.completion?(nil, err) }
            if self == nil || self!.isCancelled { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self?.image = image
            self?.completion?(image, nil)
        }
        
        if isCancelled { return }
        dataTask.resume()
    }
}

