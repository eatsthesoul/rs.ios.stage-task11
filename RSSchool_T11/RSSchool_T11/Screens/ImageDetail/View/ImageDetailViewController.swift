//
//  ImageDetailViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 23/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

private enum ImageState {
    case normal
    case editing
}

final class ImageDetailViewController: UIViewController, ImageDetailViewInput, ModuleTransitionable {

    // MARK: - Properties

    var output: ImageDetailViewOutput?
    
    //MARK: - Private Properties
    
    private var state: ImageState = .normal
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .smokyWhite
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var closeButton: CloseButton = {
        let button = CloseButton()
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
        addGestureRecognizers()
        output?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollView()
    }
    
    

    // MARK: - ImageDetailViewInput
    
    func setupImage(_ img: UIImage) {
        imageView.image = img
        view.layoutSubviews()
    }
}

//MARK: - Private methods

private extension ImageDetailViewController {
    
    func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.addSubview(imageView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func addGestureRecognizers() {
        
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(closeScreen))
        swipeDownGestureRecognizer.direction = .down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(zoomByTap))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupState(_ state: ImageState) {
        switch state {
        case .normal:
            self.state = .normal
            scrollView.backgroundColor = .smokyWhite
            closeButton.isHidden = false
        case .editing:
            self.state = .editing
            scrollView.backgroundColor = .smokyBlack
            closeButton.isHidden = true
        }
    }
    
    func updateScrollView() {
        scrollView.contentSize = imageView.bounds.size
        let scale = zoomScale()
        guard let imageHeight = imageView.image?.size.height else { return }
        let actualImageHeight = imageHeight * scale
        scrollView.contentInset = UIEdgeInsets(top: (view.bounds.height - actualImageHeight) * 0.5, left: 0, bottom: 0, right: 0)
    }
    
    func zoomScale() -> CGFloat {
        guard let imageSize = imageView.image?.size else { return 0 }
        let widthScale = view.bounds.width / imageSize.width
        let heightScale = view.bounds.height / imageSize.height
        let scale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = scale
        scrollView.maximumZoomScale = 3 * scale
        scrollView.zoomScale = scrollView.minimumZoomScale
        return scale
    }
}

//MARK: - Selectors

private extension ImageDetailViewController {
    
    @objc func tapGestureHandler() {
        state == .normal ? setupState(.editing) : setupState(.normal)
    }
    
    @objc func closeScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func zoomByTap() {
        setupState(.editing)
        let isMinScale = scrollView.zoomScale == scrollView.minimumZoomScale
        let zoomScale = isMinScale ? scrollView.maximumZoomScale : scrollView.minimumZoomScale
        scrollView.setZoomScale(zoomScale, animated: true)
    }
}

//MARK: - Zooming methods (UIScrollViewDelegate)

extension ImageDetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        setupState(.editing)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}
