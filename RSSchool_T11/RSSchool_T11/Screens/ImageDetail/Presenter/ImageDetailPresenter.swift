//
//  ImageDetailPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 23/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class ImageDetailPresenter: ImageDetailViewOutput, ImageDetailModuleInput {

    // MARK: - Properties

    weak var view: ImageDetailViewInput?
    var router: ImageDetailRouterInput?
    var output: ImageDetailModuleOutput?
    
    var url: String?
    
    private let networkService: NetworkServiceProtocol
    private var image: UIImage?
    
    init() {
        networkService = NetworkService()
    }
    
    //MARK: - Private methods
    
    private func loadImage() {
        self.view?.startLoader()
        guard let url = self.url else { return }
        networkService.imageService.loadImage(for: url) { [weak self] image, error in
            if let error = error {
                print(error)
                return
            }
            guard let image = image else { return }
            self?.image = image
            self?.view?.setupImage(image)
            self?.view?.stopLoader()
        }
    }

    // MARK: - ImageDetailViewOutput
    
    func viewDidLoad() {
        loadImage()
    }

    // MARK: - ImageDetailModuleInput
}
