//
//  NetworkService.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 17.12.21.
//

import Foundation

protocol RequestServiceProtocol {
    func fetchData(from link: Link, completion: @escaping (Data?, Error?) -> ())
    func loadRockets(completion: @escaping ([Rocket]?, Error?) -> ())
    func loadLaunches(completion: @escaping ([Launch]?, Error?) -> ())
    func loadLaunchpads(completion: @escaping ([Launchpad]?, Error?) -> ())
    func loadRocketWith(id: String, completion: @escaping (Rocket?, Error?) -> ())
}

enum Link {
    case link(scheme: String, host: String, path: String, id: String? = nil)
    
    static let rocketsLink = Link.link(scheme: "https", host: "api.spacexdata.com", path: "/v4/rockets")
    static let launchesLink = Link.link(scheme: "https", host: "api.spacexdata.com", path: "/v5/launches")
    static let launchpadsLink = Link.link(scheme: "https", host: "api.spacexdata.com", path: "/v4/launchpads")
    
    static func rocketLink(with id: String) -> Link {
        .link(scheme: "https", host: "api.spacexdata.com", path: "/v4/rockets", id: id)
    }
}

class RequestService {
    
    private func buildURL(from link: Link) -> URL? {
        switch link {
        case .link(let scheme, let host, let path, let id):
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            if let id = id { components.path += "/\(id)" }
            return components.url
        }
    }
}

// MARK: - API

extension RequestService: RequestServiceProtocol {
    
    func fetchData(from link: Link, completion: @escaping (Data?, Error?) -> ()) {
        
        guard let url = buildURL(from: link) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                completion(data, nil)
            }
        }
        dataTask.resume()
    }
    
    func loadRockets(completion: @escaping ([Rocket]?, Error?) -> ()) {
        fetchData(from: .rocketsLink) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let jsonParser = JSONParser<[Rocket]>()
            jsonParser.parseData(data) { rockets, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let rockets = rockets else { return }
                completion(rockets, nil)
            }
        }
    }
    
    func loadLaunches(completion: @escaping ([Launch]?, Error?) -> ()) {
        fetchData(from: .launchesLink) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let jsonParser = JSONParser<[Launch]>()
            jsonParser.parseData(data) { launches, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let launches = launches else { return }
                completion(launches, nil)
            }
        }
    }
    
    func loadLaunchpads(completion: @escaping ([Launchpad]?, Error?) -> ()) {
        fetchData(from: .launchpadsLink) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let jsonParser = JSONParser<[Launchpad]>()
            jsonParser.parseData(data) { launchpads, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let launchpads = launchpads else { return }
                completion(launchpads, nil)
            }
        }
    }
    
    func loadRocketWith(id: String, completion: @escaping (Rocket?, Error?) -> ()) {
        fetchData(from: .rocketLink(with: id)) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let jsonParser = JSONParser<Rocket>()
            jsonParser.parseData(data) { rocket, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let rocket = rocket else { return }
                completion(rocket, nil)
            }
        }
    }
}
