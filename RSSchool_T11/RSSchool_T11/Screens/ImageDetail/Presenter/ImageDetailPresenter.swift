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
    
    private let downloadManager = DownloadManager()
    private var image: UIImage?
    
    //MARK: - Private methods
    
    private func loadImage() {
        self.view?.startLoader()
        guard let url = self.url else { return }
        downloadManager.loadImage(for: url) { [weak self] image, error in
            if let error = error {
                print(error)
                //TODO: Error handling with alert
                return
            }
            guard let image = image else {
                //TODO: The same alert
                return
            }
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
