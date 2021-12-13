//
//  RocketsNetworkService.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 12.10.21.
//

import UIKit

protocol RocketServiceProtocol {
    func loadRockets(completion: @escaping ([Rocket]?, Error?) -> ())
    func loadRocket(with id: String, completion: @escaping (Rocket?, Error?) -> ())
}

class RocketService: RocketServiceProtocol {
    
    private let downloadManager: DownloadManagerProtocol = DownloadManager()
    private let rocketsParser = JSONParser<[Rocket]>()
    private let rocketParser = JSONParser<Rocket>()
    
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
    
    func loadRocket(with id: String, completion: @escaping (Rocket?, Error?) -> ()) {
        
        let url = rocketsURL + "/\(id)"
        downloadManager.fetchData(from: url) { [weak self] data, error in
            if let error = error { completion(nil, error) }
            
            guard let data = data else { return }
            
            self?.rocketParser.parseData(data) { rocket, error in
                if let err = error { completion(nil, err) }
                else { completion(rocket, nil) }
            }
        }
    }
}
