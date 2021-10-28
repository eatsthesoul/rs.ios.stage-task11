//
//  RocketsNetworkService.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 12.10.21.
//

import UIKit

protocol RocketServiceProtocol {
    func loadRockets(completion: @escaping ([Rocket]?, Error?) -> ())
    func loadImage(for url: String, completion: @escaping (UIImage?, Error?) -> ())
    func cancelLoadingImage(for url: String)
}

class RocketService: RocketServiceProtocol {
    
    private let downloadManager = DownloadManager()
    private let rocketsParser = JSONParser<[Rocket]>()
    
    private let rocketsURL = "https://api.spacexdata.com/v4/rockets"
    
    func loadRockets(completion: @escaping ([Rocket]?, Error?) -> ()) {
        
        downloadManager.fetchData(from: rocketsURL) { [weak self] data, error in
            if let error = error { completion(nil, error) }
            
            guard let data = data else { return }
            
            self?.rocketsParser.parseData(data) { rockets, error in
                if let err = error { completion(nil, err) }
                else { completion(rockets, nil) }
            }
        }
    }
    
    func loadImage(for url: String, completion: @escaping (UIImage?, Error?) -> ()) {
        downloadManager.loadImage(for: url) { image, error in
            completion(image, error)
        }
    }
    
    func cancelLoadingImage(for url: String) {
        downloadManager.cancelDownloadingOperation(for: url)
    }
}
