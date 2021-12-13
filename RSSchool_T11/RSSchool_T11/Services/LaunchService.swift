//
//  LaunchService.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 8.12.21.
//

import UIKit

protocol LaunchServiceProtocol {
    func loadLaunches(completion: @escaping ([Launch]?, Error?) -> ())
}

class LaunchService: LaunchServiceProtocol {
    
    private let downloadManager = DownloadManager()
    private let launchesParser = JSONParser<[Launch]>()
    
    private let launchesURL = "https://api.spacexdata.com/v5/launches"
    
    func loadLaunches(completion: @escaping ([Launch]?, Error?) -> ()) {
        
        downloadManager.fetchData(from: launchesURL) { [weak self] data, error in
            if let error = error { completion(nil, error) }
            
            guard let data = data else { return }
            
            self?.launchesParser.parseData(data) { rockets, error in
                if let err = error { completion(nil, err) }
                else { completion(rockets, nil) }
            }
        }
    }
}
