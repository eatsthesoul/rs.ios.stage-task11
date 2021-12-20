//
//  NetworkServiceProtocol.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 17.12.21.
//

import Foundation

protocol NetworkServiceProtocol {
    var requestService: RequestServiceProtocol { get }
    var imageService: ImageServiceProtocol { get }
}

class NetworkService: NetworkServiceProtocol {
    let requestService: RequestServiceProtocol
    let imageService: ImageServiceProtocol
    
    init() {
        requestService = RequestService()
        imageService = ImageService()
    }
}
